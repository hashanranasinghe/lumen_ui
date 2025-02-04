import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A modern linear progress indicator.
///
/// This widget displays a horizontal progress bar with customizable colors
/// and height. It is ideal for showing progress in tasks like file uploads.
class Template extends StatelessWidget {
  /// The color of the progress bar.
  /// Defaults to `AppColors.md_theme_light_primary`.
  final Color color;

  /// The background color of the progress bar.
  /// Defaults to `AppColors.light_gray`.
  final Color backgroundColor;

  /// The height of the progress bar.
  /// Defaults to `8.0`.
  final double height;

  /// Creates a modern linear progress indicator.
  ///
  /// [color], [backgroundColor], and [height] can be customized to match your design system.
  const Template({
    Key? key,
    this.color = AppColors.md_theme_light_primary,
    this.backgroundColor = AppColors.light_gray,
    this.height = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0), // Rounded corners
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color), // Custom color
        backgroundColor: backgroundColor, // Background color
        minHeight: height, // Height of the progress bar
      ),
    );
  }
}

/// ## Usage Example:
/// ```dart
/// ModernLinearProgressIndicator(
///   color: AppColors.blue,
///   backgroundColor: AppColors.white_gray,
///   height: 12.0,
/// )
/// ```