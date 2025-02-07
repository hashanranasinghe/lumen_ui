import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A modern circular progress indicator.
///
/// This widget displays a circular loading spinner with customizable colors
/// and size. It is ideal for indicating ongoing processes like data fetching.
class Template extends StatelessWidget {
  /// The color of the progress indicator.
  /// Defaults to `AppColors.md_theme_light_primary`.
  final Color color;

  /// The size (diameter) of the progress indicator.
  /// Defaults to `40.0`.
  final double size;

  /// Creates a modern circular progress indicator.
  ///
  /// [color] and [size] can be customized to match your design system.
  const Template({
    Key? key,
    this.color = AppColors.md_theme_light_primary,
    this.size = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, // Width of the circular indicator
      height: size, // Height of the circular indicator
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color), // Custom color
        strokeWidth: 4.0, // Thickness of the progress line
      ),
    );
  }
}

/// ## Usage Example:
/// ```dart
/// Center(
///   child: ModernCircularProgressIndicator(
///     color: AppColors.green,
///     size: 50.0,
///   ),
/// )
/// ```