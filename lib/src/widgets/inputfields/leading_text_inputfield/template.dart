import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// Built for reusable form fields with integrated styling, validation, and theming.
///
/// ### Parameters:
/// - [controller] (required): Controls the text being edited.
/// - [onChanged] (required): Called when the input value changes.
/// - [validator] (required): Validation function for the input value.
/// - [hintText]: Placeholder text. Default is `"Text"`.
/// - [keyboardType]: Type of keyboard. Default is `TextInputType.text`.
/// - [maxLines]: Number of lines. Default is `1`.
/// - [padding]: Inner padding. Default is `EdgeInsets.all(16)`.
/// - [prefixIcon] (required): Icon displayed at the start of the field.
class Template extends StatelessWidget {
  final TextInputType keyboardType;
  final int maxLines;
  final Widget prefixIcon;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  const Template({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.validator,
    this.hintText = "Text",
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.padding = const EdgeInsets.all(16),
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      cursorColor: AppColors.fontPrimary,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.fontPrimary,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        contentPadding: padding,
        border: _buildDefaultBorder(),
        enabledBorder: _buildDefaultBorder(),
        focusedBorder: _buildFocusedBorder(),
        filled: true,
        fillColor: AppColors.background,
      ).applyDefaults(themeData.inputDecorationTheme),
    );
  }

  OutlineInputBorder _buildDefaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.outline,
        width: 1.5,
      ),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 2.0,
      ),
    );
  }
}

/// ### Example Usage:
/// ```dart
/// Template(
///   controller: TextEditingController(),
///   onChanged: (value) => print(value),
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
///   prefixIcon: Icon(Icons.person, color: AppColors.md_theme_light_font),
///   hintText: 'Enter name',
/// )
/// ```
