import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A modern card component for Flutter applications.
///
/// This widget provides a reusable and stylish card with customizable content,
/// colors, and styling based on your `AppColors` and `AppStyle`.
class Template extends StatelessWidget {
  /// The title displayed at the top of the card (optional).
  final String? title;

  /// The subtitle displayed below the title (optional).
  final String? subtitle;

  /// The main content widget displayed inside the card (optional).
  final Widget? content;

  /// The footer widget displayed at the bottom of the card (optional).
  final Widget? footer;

  /// The background color of the card.
  /// Defaults to `AppColors.md_theme_light_surface`.
  final Color backgroundColor;

  /// The border radius of the card.
  /// Defaults to `12.0`.
  final double borderRadius;

  /// The padding applied inside the card.
  /// Defaults to `EdgeInsets.all(16.0)`.
  final EdgeInsetsGeometry padding;

  /// The elevation of the card.
  /// Defaults to `4.0`.
  final double elevation;

  /// Creates a modern card.
  ///
  /// [content] is the main widget displayed inside the card. Other parameters
  /// provide customization options for the card's appearance and behavior.
  const Template({
    Key? key,
    this.title,
    this.subtitle,
    this.content,
    this.footer,
    this.backgroundColor = AppColors.md_theme_light_surface,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation, // Elevation for shadow effect
      color: backgroundColor, // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
      ),
      child: Padding(
        padding: padding, // Apply custom padding
        child: Column(
          mainAxisSize: MainAxisSize.min, // Align items vertically
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: AppStyle.textHeadline5Reg.copyWith(
                  color: AppColors.md_theme_light_onSurface,
                ),
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  subtitle!,
                  style: AppStyle.textSubtitle1Reg.copyWith(
                    color: AppColors.md_theme_light_onSurfaceVariant,
                  ),
                ),
              ),
            if (title != null || subtitle != null)
              const SizedBox(
                  height: 12), // Spacing between title/subtitle and content
            if (content != null) content!, // Main content widget
            if (footer != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: footer!, // Footer widget
              ),
          ],
        ),
      ),
    );
  }
}
