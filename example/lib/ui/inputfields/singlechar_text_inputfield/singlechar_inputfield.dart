import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';

/// A single-character input field with validation and customizable styling.
///
/// Designed for inputs like OTPs, initials, or custom single-char fields,
/// this widget restricts input to 1 character and offers clean theming options.
///
/// ### Features:
/// - Custom background and padding
/// - Built-in validation support
/// - Text input limited to a single character
/// - Themed with rounded corners and color options
///
/// ### Parameters:
/// - [controller] (required): Manages the text being edited.
/// - [onChanged] (required): Callback triggered when the input changes.
/// - [validator] (required): Returns error message if validation fails.
/// - [hintText]: Placeholder text. Default is an empty string.
/// - [keybordtype]: Keyboard type. Default is `TextInputType.number`.
/// - [maxLine]: Max vertical lines. Default is `1`.
/// - [background]: Field background color. Default is `AppColors.white`.
/// - [padding]: Outer padding around the field. Default is `EdgeInsets.all(10)`.
///
/// ### Example Usage:
/// ```dart
/// Singlechartextinputfield(
///   hintText: "Enter",
///   controller: TextEditingController(),
///   onChanged: (val) => print(val),
///   validator: (val) => val == null || val.isEmpty ? 'Required' : null,
/// )
/// ```
class Singlechartextinputfield extends StatelessWidget {
  final TextInputType keybordtype;
  final int maxLine;
  final String hintText;
  final Color background;
  final EdgeInsetsGeometry padding;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  const Singlechartextinputfield({
    Key? key,
    this.hintText = "",
    this.keybordtype = TextInputType.number,
    this.maxLine = 1,
    this.background = AppColors.white,
    this.padding = const EdgeInsets.all(10),
    required this.controller,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLine,
        maxLength: 1, // Restrict input to a single character
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.fontPrimary,
        ),
        cursorColor: AppColors.fontPrimary,
        keyboardType: keybordtype,
        decoration: InputDecoration(
          filled: true,
          fillColor: background,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
          ),
          contentPadding: const EdgeInsets.all(20.0),
          counter: const Offstage(), // Hides the character counter
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.appPrimary,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
        ).applyDefaults(themeData.inputDecorationTheme),
      ),
    );
  }
}
