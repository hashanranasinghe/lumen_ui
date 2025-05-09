import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';
import 'package:example/ui/styles/styles.dart';

/// A clean and reusable outlined icon button with optional label.
/// 
/// This widget shows an outlined border with an icon and optional label,
/// useful for secondary actions or lightweight buttons.
///
/// ### Parameters:
/// - [icon] (required): Icon to show inside the button.
/// - [label] (required): Text displayed next to the icon.
/// - [onPressed] (required): Function triggered when the button is tapped.
/// - [borderColor]: Outline color for the border and icon. Default is `AppColors.primary`.
/// - [textColor]: Color of the text and icon. Default is `AppColors.primary`.
/// - [iconSize]: Size of the icon. Default is `24.0`.
/// - [borderRadius]: Rounded corners. Default is `8.0`.
/// - [padding]: Padding inside the button. Default is `EdgeInsets.symmetric(horizontal: 16, vertical: 12)`.
/// - [width]: Width of the button. Default is `double.infinity`.
class Iconoutlinedbutton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color borderColor;
  final double width;
  final Color textColor;
  final double iconSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const Iconoutlinedbutton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.borderColor = AppColors.primary,
    this.textColor = AppColors.primary,
    this.iconSize = 24.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: textColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppStyle.textButtonReg.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ### Example Usage:
/// ```dart
/// Iconoutlinedbutton(
///   icon: Icons.add,
///   label: "Add Item",
///   onPressed: () {
///     print("Add button tapped!");
///   },
/// )
/// ```
