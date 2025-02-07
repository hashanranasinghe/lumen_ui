import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A modern and customizable icon button component for Flutter applications.
///
/// This widget provides a reusable and stylish button that combines an icon
/// with an optional label. It supports both filled and outlined styles,
/// customizable colors, padding, and border radius for a polished look.
///
/// ## Parameters:
/// - [icon]: The icon displayed on the button (required).
/// - [label]: The optional text label displayed next to the icon.
/// - [onPressed]: The callback triggered when the button is pressed (required).
/// - [backgroundColor]: The background color of the button.
///   Defaults to `AppColors.primary`.
/// - [iconColor]: The color of the icon.
///   Defaults to `AppColors.white`.
/// - [labelColor]: The color of the label text (optional).
///   If not provided, it defaults to `iconColor`.
/// - [iconSize]: The size of the icon.
///   Defaults to `24.0`.
/// - [borderRadius]: The border radius of the button.
///   Defaults to `8.0`.
/// - [padding]: The padding applied inside the button.
///   Defaults to `EdgeInsets.all(12.0)`.
/// - [isOutlined]: Whether the button should have an outlined style.
///   Defaults to `false`.
///
/// ## Usage Example:
/// ```dart
/// class MyScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: Text("Modern Icon Button")),
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             ModernIconButton(
///               icon: Icons.add,
///               label: "Add Item",
///               onPressed: () {
///                 print("Add button pressed");
///               },
///               backgroundColor: AppColors.primary,
///               iconColor: AppColors.white,
///               labelColor: AppColors.white,
///               borderRadius: 12.0,
///             ),
///             SizedBox(height: 20),
///             ModernIconButton(
///               icon: Icons.delete,
///               onPressed: () {
///                 print("Delete button pressed");
///               },
///               backgroundColor: Colors.transparent,
///               iconColor: AppColors.error,
///               isOutlined: true,
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
class Template extends StatelessWidget {
  /// The icon displayed on the button.
  final IconData icon;

  /// The optional text label displayed next to the icon.
  final String? label;

  /// The callback triggered when the button is pressed.
  final VoidCallback onPressed;

  /// The background color of the button.
  final Color backgroundColor;

  /// The color of the icon.
  final Color iconColor;

  /// The color of the label text (optional).
  final Color? labelColor;

  /// The size of the icon.
  final double iconSize;

  /// The border radius of the button.
  final double borderRadius;

  /// The padding applied inside the button.
  final EdgeInsetsGeometry padding;

  /// Whether the button should have an outlined style.
  final bool isOutlined;

  /// Creates a modern and customizable icon button.
  ///
  /// [icon] and [onPressed] are required parameters. Other parameters provide
  /// customization options for the button's appearance and behavior.
  const Template({
    Key? key,
    required this.icon,
    this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.appPrimary,
    this.iconColor = AppColors.white,
    this.labelColor,
    this.iconSize = 24.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(12.0),
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Triggered when the button is tapped
      child: Container(
        padding: padding, // Apply custom padding
        decoration: BoxDecoration(
          color: isOutlined
              ? Colors.transparent
              : backgroundColor, // Background color
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
          border: isOutlined
              ? Border.all(
                  color: backgroundColor, width: 2.0) // Outlined border
              : null,
          boxShadow: isOutlined
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Subtle shadow
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Align items horizontally
          children: [
            Icon(
              icon,
              size: iconSize, // Icon size
              color: isOutlined ? backgroundColor : iconColor, // Icon color
            ),
            if (label != null) ...[
              const SizedBox(width: 8), // Spacing between icon and label
              Text(
                label!,
                style: AppStyle.textButtonReg.copyWith(
                  color: isOutlined
                      ? backgroundColor
                      : labelColor ?? iconColor, // Label color
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
