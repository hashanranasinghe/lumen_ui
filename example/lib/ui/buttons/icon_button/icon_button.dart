import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';
import 'package:example/ui/styles/styles.dart';

/// A customizable icon button widget with optional label and styling options.
/// 
/// This button supports filled and outlined styles with adjustable colors,
/// padding, and rounded corners. It’s designed for reusability and clean UI.
///
/// ### Parameters:
/// - [icon] (required): Icon to display inside the button.
/// - [label]: Optional text next to the icon. Defaults to `"Button"`.
/// - [onPressed] (required): Function called when button is tapped.
/// - [backgroundColor]: Button fill color. Default is `AppColors.appPrimary`.
/// - [iconColor]: Icon color. Default is `AppColors.white`.
/// - [labelColor]: Label text color. Defaults to [iconColor] if not provided.
/// - [iconSize]: Icon size. Default is `24.0`.
/// - [borderRadius]: Corner radius. Default is `8.0`.
/// - [padding]: Padding inside the button. Default is `EdgeInsets.all(12.0)`.
/// - [isOutlined]: If true, shows a border and transparent background. Default is `false`.
/// - [width]: Width of the button. Default is `double.infinity`.
class Iconbutton extends StatelessWidget {
  final IconData icon;
  final double width;
  final String? label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final Color? labelColor;
  final double iconSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isOutlined;

  const Iconbutton({
    Key? key,
    required this.icon,
    this.label = "Button",
    required this.onPressed,
    this.backgroundColor = AppColors.appPrimary,
    this.iconColor = AppColors.white,
    this.labelColor,
    this.iconSize = 24.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(12.0),
    this.isOutlined = false,
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
          color: isOutlined ? Colors.transparent : backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: isOutlined ? Border.all(color: backgroundColor, width: 2.0) : null,
          boxShadow: isOutlined
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: isOutlined ? backgroundColor : iconColor,
            ),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(
                label!,
                style: AppStyle.textButtonReg.copyWith(
                  color: isOutlined
                      ? backgroundColor
                      : labelColor ?? iconColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// ### Example Usage:
/// ```dart
/// Iconbutton(
///   icon: Icons.favorite,
///   label: "Like",
///   onPressed: () {
///     print("Liked!");
///   },
/// )
/// ```
