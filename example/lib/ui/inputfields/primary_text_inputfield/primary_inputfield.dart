import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';

/// A primary text input field with label, validation, and styling.
///
/// Features:
/// - Customizable label, hint, and font size
/// - Validation, save, and change handling
/// - Adaptive styling with border radius and padding
/// - Keyboard type and input action configuration
///
/// ### Parameters:
/// - [controller] (required): Controls the text field.
/// - [onChanged] (required): Called when the input changes.
/// - [onSaved] (required): Called when the form is saved.
/// - [validator] (required): Returns an error string if validation fails.
/// - [label]: Field label text. Default is `"Textfield"`.
/// - [hintText]: Placeholder text. Default is `"Text"`.
/// - [keyboardType]: Keyboard type. Default is `TextInputType.text`.
/// - [textInputAction]: Action button on keyboard. Default is `TextInputAction.none`.
/// - [maxLines]: Max number of lines. Default is `1`.
/// - [width]: Width of the field. Default is `double.infinity`.
/// - [fontSize]: Text size. Default is `16`.
/// - [borderRadius]: Border curve. Default is `10`.

class Primarytextinputfield extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int maxLines;
  final double width;
  final double fontSize;
  final double borderRadius;
  final TextInputAction textInputAction;

  final Function(String) onChanged;
  final Function(String?) onSaved;
  final String? Function(String?) validator;

  const Primarytextinputfield({
    Key? key,
    this.label = "Textfield",
    this.hintText = "Text",
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.width = double.infinity,
    this.fontSize = 16,
    this.borderRadius = 10,
    this.textInputAction = TextInputAction.none,
    required this.controller,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: width,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          style: TextStyle(fontSize: fontSize, color: AppColors.fontPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(251, 251, 251, 0.79),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: AppColors.outline,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: fontSize,
              color: Colors.grey[500],
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            border: _outlineBorder(borderRadius, AppColors.outline, 1.0),
            enabledBorder: _outlineBorder(borderRadius, AppColors.outline, 1.0),
            focusedBorder: _outlineBorder(borderRadius, AppColors.appPrimary, 2.0),
            errorBorder: _outlineBorder(borderRadius, Colors.red, 1.0),
            focusedErrorBorder: _outlineBorder(borderRadius, Colors.red, 2.0),
          ),
        ),
      ),
    );
  }

  /// Creates a styled border with given radius, color, and width.
  OutlineInputBorder _outlineBorder(double radius, Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
///
/// ### Example Usage:
/// ```dart
/// Primarytextinputfield(
///   label: 'Username',
///   hintText: 'Enter username',
///   controller: TextEditingController(),
///   onChanged: (value) => print(value),
///   validator: (value) => value!.isEmpty ? 'Field is required' : null,
///   onSaved: (value) => print('Saved: $value'),
/// )
/// ```