import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A modern icon-based toast notification.
///
/// This widget displays a customizable message with an icon and background
/// color. It is ideal for creating versatile toast notifications.
class Template extends StatelessWidget {
  /// The message displayed in the toast.
  final String message;

  /// The icon displayed in the toast.
  final IconData icon;

  /// The background color of the toast.
  final Color backgroundColor;

  /// The color of the icon and text.
  final Color textColor;

  /// Creates an icon-based toast notification.
  ///
  /// [message], [icon], [backgroundColor], and [textColor] can be customized
  /// to match your design system.
  const Template({
    Key? key,
    required this.message,
    required this.icon,
    this.backgroundColor = AppColors.md_theme_light_primary,
    this.textColor = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor, // Customizable background color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, // Customizable icon
            color: textColor, // Customizable icon color
            size: 24,
          ),
          const SizedBox(width: 8), // Spacing between icon and text
          Flexible(
            child: Text(
              message,
              style: AppStyle.textBody1Reg.copyWith(
                color: textColor, // Customizable text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ## Usage Example:
/// ```dart
/// ScaffoldMessenger.of(context).showSnackBar(
///   SnackBar(
///     content: IconToast(
///       message: "Profile updated successfully!",
///       icon: Icons.person,
///       backgroundColor: AppColors.green,
///       textColor: AppColors.white,
///     ),
///     backgroundColor: Colors.transparent, // Transparent background for custom styling
///     elevation: 0,
///     behavior: SnackBarBehavior.floating,
///   ),
/// );
/// ```