import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable text input field component for Flutter applications.
///
/// This widget provides a reusable and customizable text input field with
/// features like validation, dynamic width, and keyboard type configuration.
/// It also includes a clean and modern design with rounded borders and
/// attractive styling.
class Template extends StatelessWidget {
  /// The label displayed above the text field.
  final String label;

  /// The type of keyboard to display for the text field.
  final TextInputType keybordtype;

  /// The controller used to manage the text field's content.
  final TextEditingController controller;

  /// The placeholder text displayed when the text field is empty.
  final String hintText;

  /// The maximum number of lines the text field can expand to.
  final int maxLines;

  /// The width of the text field.
  final double width;

  /// The action button on the keyboard (e.g., "Done", "Next").
  final TextInputAction textInputAction;

  /// Callback triggered when the text in the field changes.
  final Function(String) onchange;

  /// Callback triggered when the form is saved.
  final Function(String?) save;

  /// Validator function to validate the input.
  final String? Function(String?) valid;

  /// Creates a customizable text input field.
  ///
  /// [label] is required and will be displayed above the text field.
  /// [onchange], [valid], and [save] are required callbacks for handling
  /// input changes, validation, and saving the form data.
  const Template({
    this.textInputAction = TextInputAction.none,
    this.hintText = "Text",
    required this.onchange,
    required this.valid,
    required this.save,
    Key? key,
    required this.controller,
    this.label = "Textfield",
    this.keybordtype = TextInputType.text,
    this.width = 500.0,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: width,
        child: TextFormField(
          // Keyboard and input behavior
          textInputAction: textInputAction,
          maxLines: maxLines,
          keyboardType: keybordtype,
          onChanged: onchange, // Triggered when the text changes
          onSaved: save, // Triggered when the form is saved
          controller: controller, // Manages the text field's content
          validator: valid, // Validates the input

          // Styling and decoration
          decoration: InputDecoration(
            fillColor:
                const Color.fromRGBO(251, 251, 251, 0.79), // Background color
            filled: true,
            labelText: label, // Label displayed above the text field
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.outline, // Label text color
            ),
            hintText: hintText, // Placeholder text
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[500], // Hint text color
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ), // Padding inside the text field
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: AppColors
                    .outline, // Border color when enabled
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: AppColors.appPrimary, // Border color when focused
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Colors.red, // Border color for errors
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Colors.red, // Border color for focused errors
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
