import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A modern outlined button component for Flutter applications.
///
/// This widget extends Flutter's built-in OutlinedButton for better
/// accessibility and behavior while providing a consistent design
/// that aligns with the application's styling.
class Template extends StatelessWidget {
  /// The text label displayed on the button (required).
  final String label;

  /// The callback triggered when the button is pressed (required).
  final VoidCallback onPressed;

  /// The color of the button's border and text.
  /// Defaults to `AppColors.dark_black`.
  final Color color;

  /// The border radius of the button.
  /// Defaults to `8.0`.
  final double borderRadius;

  /// Optional icon to display before the label.
  final IconData? leadingIcon;

  /// Controls whether the button spans the full width of its parent.
  /// Defaults to `false`.
  final bool isFullWidth;

  /// Optional custom padding for the button.
  /// If null, appropriate default padding will be applied.
  final EdgeInsetsGeometry? padding;

  /// Creates a modern outlined button.
  ///
  /// [label] and [onPressed] are required parameters. Other parameters provide
  /// customization options for the button's appearance and behavior.
  const Template({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.black,
    this.borderRadius = 8.0,
    this.leadingIcon,
    this.isFullWidth = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonPadding = padding ?? 
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    // Create button style with our custom specifications
    final buttonStyle = OutlinedButton.styleFrom(
      foregroundColor: color,
      padding: buttonPadding,
      side: BorderSide(color: color, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      minimumSize: isFullWidth ? const Size.fromHeight(48) : null,
    );

    // Create the button with appropriate content
    return OutlinedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: _buildButtonContent(),
    );
  }

  /// Builds the internal content of the button based on configuration.
  Widget _buildButtonContent() {
    // If we have a leading icon, create a row with icon and text
    if (leadingIcon != null) {
      return Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(leadingIcon, size: 18),
          const SizedBox(width: 8),
          Text(label, style: AppStyle.textButtonReg),
        ],
      );
    }
    
    // Otherwise just return the text
    return Text(label, style: AppStyle.textButtonReg);
  }
}