import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A customizable date picker input field with text input display.
/// 
/// This widget combines a text field with a date picker functionality, allowing users
/// to select dates from a calendar interface. The selected date displays in the text field.
/// The widget supports customization of appearance and behavior including past/future date restrictions.
///
/// ### Parameters:
/// - [controller] (required): TextEditingController to manage the field's value
/// - [hintText]: Placeholder text shown when no date is selected. Default is `"Select Date"`
/// - [radius]: Corner radius of the input field. Default is `15.0`
/// - [iconData]: Calendar icon displayed at the end of the field. Default is `Icons.calendar_month_outlined`
/// - [validMsg]: Optional validation message shown when field is empty
/// - [isOutilneFiled]: If true, displays as outlined input field with floating label. Default is `true`
/// - [isDisable]: If true, makes the field read-only and non-interactive. Default is `false`
/// - [initialDate]: Initial date to show when opening the date picker. Default is current date
/// - [isUpcomming]: If true, only allows future dates to be selected. Default is `false`
/// - [showAllDates]: If true, ignores past/future restrictions and shows all dates. Default is `false`
class Template extends StatefulWidget {
  final double radius;
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;
  final String? validMsg;
  final bool isOutilneFiled;
  final bool isDisable;
  final DateTime? initialDate;
  final bool isUpcomming; // Show only upcoming dates if true, past dates if false
  final bool showAllDates; // Show all dates and ignore upcoming/past filter

  const Template({
    Key? key,
    required this.controller,
    this.hintText = "Select Date",
    this.radius = 15,
    this.iconData = Icons.calendar_month_outlined,
    this.validMsg,
    this.isOutilneFiled = true,
    this.isDisable = false,
    this.isUpcomming = false,
    this.showAllDates = false,
    this.initialDate,
  }) : super(key: key);

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  /// Opens the date picker dialog and updates the text field with selected date
  void _showDatePicker() {
    // Don't show date picker if widget is disabled
    if (widget.isDisable) return;
    
    // Configure date picker options based on widget parameters
    final DateTime now = DateTime.now();
    final DateTime firstDate = widget.showAllDates
        ? DateTime(1920)
        : widget.isUpcomming
            ? now
            : DateTime(1920);
    final DateTime lastDate = widget.showAllDates
        ? DateTime(2200)
        : widget.isUpcomming
            ? DateTime(2100)
            : now;

    showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return FittedBox(
          child: Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: AppColors.appPrimary,
              ),
            ),
            child: child!,
          ),
        );
      },
    ).then((selectedDate) {
      // Update controller text if date was selected
      if (selectedDate != null) {
        widget.controller.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    
    return GestureDetector(
      onTap: _showDatePicker,
      child: AbsorbPointer(
        // Prevents direct text input, forcing users to use the date picker
        child: TextFormField(
          readOnly: true,
          enabled: !widget.isDisable,
          controller: widget.controller,
          validator: (value) {
            // Simple validation to check if a date was selected
            if (widget.validMsg != null && (value == null || value.isEmpty)) {
              return widget.validMsg;
            }
            return null;
          },
          cursorHeight: Platform.isIOS ? 16 : 18,
          cursorColor: AppColors.lightGray,
          style: AppStyle.fieldText,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            suffixIcon: Icon(
              widget.iconData,
              color: AppColors.primary,
            ),
            // Apply outline or filled style based on isOutilneFiled flag
            hintText: widget.isOutilneFiled ? null : widget.hintText,
            label: widget.isOutilneFiled
                ? Text(
                    widget.hintText,
                    style: AppStyle.fieldText,
                  )
                : null,
            // Apply theme defaults and customize border radius
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: widget.isDisable 
                    ? AppColors.lightGray.withOpacity(0.5) 
                    : AppColors.primary.withOpacity(0.8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(
                color: AppColors.appPrimary,
                width: 2.0,
              ),
            ),
          ).applyDefaults(themeData.inputDecorationTheme),
        ),
      ),
    );
  }
}

/// ### Example Usage:
/// ```dart
/// TextEditingController _dateController = TextEditingController();
/// 
/// DatePickTextInputField(
///   controller: _dateController,
///   hintText: "Select Birthday",
///   validMsg: "Please select a date",
///   isUpcomming: false,
///   showAllDates: true,
/// )
/// ```