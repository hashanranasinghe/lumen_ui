import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A modern outlined button component for Flutter applications.
///
/// This widget provides a reusable and stylish outlined button with a label.
/// It supports customizable colors, padding, border radius, and text styles
/// based on your `AppColors` and `AppStyle`.
class Template extends StatelessWidget {
  /// The text label displayed on the button (required).
  final String label;

  /// The callback triggered when the button is pressed (required).
  final VoidCallback onPressed;

  /// The color of the button's border and text.
  /// Defaults to `AppColors.md_theme_light_primary`.
  final Color borderColor;

  /// The color of the text.
  /// Defaults to `AppColors.md_theme_light_primary`.
  final Color textColor;

  /// The border radius of the button.
  /// Defaults to `8.0`.
  final double borderRadius;

  /// The padding applied inside the button.
  /// Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 12)`.
  final EdgeInsetsGeometry padding;

  /// Creates a modern outlined button.
  ///
  /// [label] and [onPressed] are required parameters. Other parameters provide
  /// customization options for the button's appearance and behavior.
  const Template({
    Key? key,
    required this.label,
    required this.onPressed,
    this.borderColor = AppColors.md_theme_light_primary,
    this.textColor = AppColors.md_theme_light_primary,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Triggered when the button is tapped
      child: Container(
        padding: padding, // Apply custom padding
        decoration: BoxDecoration(
          color:
              Colors.transparent, // Transparent background for outlined style
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
          border: Border.all(
            color: borderColor, // Border color
            width: 1.5, // Border thickness
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppStyle.textButtonReg.copyWith(
              color: textColor, // Text color
            ),
          ),
        ),
      ),
    );
  }
}
