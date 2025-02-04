import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A percentage-based progress indicator.
///
/// This widget displays a circular progress indicator with a percentage label
/// in the center. It is ideal for showing completion rates or progress levels.
class Template extends StatelessWidget {
  /// The progress value (between 0.0 and 1.0).
  final double progress;

  /// The color of the progress indicator.
  /// Defaults to `AppColors.md_theme_light_primary`.
  final Color color;

  /// The size (diameter) of the progress indicator.
  /// Defaults to `100.0`.
  final double size;

  /// Creates a percentage-based progress indicator.
  ///
  /// [progress] defines the completion rate (e.g., 0.75 for 75%). [color] and
  /// [size] can be customized to match your design system.
  const Template({
    Key? key,
    required this.progress,
    this.color = AppColors.md_theme_light_primary,
    this.size = 100.0,
  })  : assert(progress >= 0.0 && progress <= 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: progress, // Progress value
            valueColor: AlwaysStoppedAnimation<Color>(color), // Custom color
            strokeWidth: 8.0, // Thickness of the progress line
          ),
        ),
        Text(
          "${(progress * 100).toInt()}%", // Percentage label
          style: AppStyle.textHeadline5Reg.copyWith(
            color: AppColors.md_theme_light_onSurface,
          ),
        ),
      ],
    );
  }
}

/// ## Usage Example:
/// ```dart
/// PercentageProgressIndicator(
///   progress: 0.6,
///   color: AppColors.completed,
///   size: 120.0,
/// )
/// ```