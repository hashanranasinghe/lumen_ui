import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable text input field component for Flutter applications.
///
/// This widget provides a reusable and customizable text input field with
/// features like validation, dynamic background color, and keyboard type
/// configuration. It also includes a clean and modern design with rounded
/// borders and attractive styling.
///
/// ## Parameters:
/// - [hintText]: The placeholder text displayed when the text field is empty.
///   Defaults to an empty string.
/// - [keybordtype]: The type of keyboard to display (e.g., number, text).
///   Defaults to `TextInputType.number`.
/// - [maxLine]: The maximum number of lines the text field can expand to.
///   Defaults to `1`.
/// - [background]: The background color of the text field.
///   Defaults to `AppColors.light_gray`.
/// - [padding]: Padding applied around the text field.
///   Defaults to `EdgeInsets.all(10)`.
/// - [controller]: The controller used to manage the text field's content.
/// - [onchange]: Callback triggered when the text in the field changes.
/// - [valid]: Validator function to validate the input.
///
/// ## Usage Example:
/// ```dart
/// class MyForm extends StatelessWidget {
///   final TextEditingController _controller = TextEditingController();
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: Text("Custom Text Field")),
///       body: Padding(
///         padding: const EdgeInsets.all(16.0),
///         child: Column(
///           children: [
///             Template(
///               hintText: "Enter a number",
///               controller: _controller,
///               onchange: (value) {
///                 print("Value changed: $value");
///               },
///               valid: (value) {
///                 if (value == null || value.isEmpty) {
///                   return "Field cannot be empty";
///                 }
///                 return null;
///               },
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
class Template extends StatelessWidget {
  /// The type of keyboard to display for the text field.
  final TextInputType keybordtype;

  /// The maximum number of lines the text field can expand to.
  final int maxLine;

  /// The placeholder text displayed when the text field is empty.
  final String hintText;

  /// The background color of the text field.
  final Color background;

  /// Padding applied around the text field.
  final EdgeInsetsGeometry padding;

  /// The controller used to manage the text field's content.
  final TextEditingController controller;

  /// Callback triggered when the text in the field changes.
  final Function(String) onchange;

  /// Validator function to validate the input.
  final String? Function(String?) valid;

  /// Creates a customizable text input field.
  ///
  /// [hintText] is optional and will be displayed as a placeholder.
  /// [onchange] and [valid] are required callbacks for handling input changes
  /// and validation. The [controller] is required to manage the text field's
  /// content.
  const Template({
    this.hintText = "",
    Key? key,
    required this.controller,
    this.keybordtype = TextInputType.number,
    this.maxLine = 1,
    this.background = AppColors.lightGray,
    this.padding = const EdgeInsets.all(10),
    required this.onchange,
    required this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the theme data for consistent styling
    final themeData = Theme.of(context);

    return Padding(
      padding: padding, // Apply custom padding
      child: TextFormField(
        onChanged: onchange, // Triggered when the text changes
        controller: controller, // Manages the text field's content
        validator: valid, // Validates the input
        maxLines: maxLine, // Maximum number of lines
        maxLength: 1, // Restricts input to a single character
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.fontPrimary, // Text color
        ),
        cursorColor: AppColors.fontPrimary, // Cursor color
        keyboardType: keybordtype, // Keyboard type
        decoration: InputDecoration(
          filled: true, // Enable background fill
          fillColor: background, // Background color
          hintText: hintText, // Placeholder text
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[500], // Hint text color
          ),
          contentPadding:
              const EdgeInsets.all(20.0), // Padding inside the field
          counter: const Offstage(), // Hide character counter
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            borderSide: BorderSide.none, // Remove default border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // No border when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.appPrimary, // Border color when focused
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red, // Border color for errors
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red, // Border color for focused errors
              width: 2.0,
            ),
          ),
        ).applyDefaults(themeData.inputDecorationTheme), // Apply theme defaults
      ),
    );
  }
}
