import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';
import 'package:example/ui/styles/styles.dart';

/// A customizable outlined button widget with optional icon support.
///
/// This component uses a `GestureDetector` to create a styled outlined button
/// that fits modern app designs. It offers full-width layout, rounded corners,
/// customizable border width, and optional leading icon.
///
/// ### Parameters:
/// - [label] (required): Text displayed on the button.
/// - [onPressed] (required): Function called when button is tapped.
/// - [color]: Color for border and text. Default is `AppColors.black`.
/// - [borderRadius]: Corner radius. Default is `8.0`.
/// - [leadingIcon]: Optional icon displayed before the label.
/// - [width]: Width of the button. Default is `double.infinity`.
/// - [borderWidth]: Thickness of the border. Default is `2.0`.
/// - [padding]: Custom padding. Defaults to vertical: 12, horizontal: 16.
class Outlinedbutton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double width;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;

  const Outlinedbutton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.black,
    this.borderRadius = 8.0,
    this.padding,
    this.width = double.infinity,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: buttonPadding,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: color, width: borderWidth),
        ),
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppStyle.textButtonReg.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// ### Example Usage:
/// ```dart
/// Outlinedbutton(
///   label: "Cancel",
///   onPressed: () {
///     print("Cancel tapped");
///   },
///   leadingIcon: Icons.close,
/// )
/// ```
