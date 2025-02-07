import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A modern failure toast notification.
///
/// This widget displays an error message with an error icon and a red
/// background. It is ideal for notifying users of failed actions.
class Template extends StatelessWidget {
  /// The message displayed in the toast.
  final String message;

  /// Creates a failure toast notification.
  ///
  /// [message] is required and will be displayed in the toast.
  const Template({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.canceled, // Red background for failure
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline, // Error icon
            color: AppColors.white, // White icon
            size: 24,
          ),
          const SizedBox(width: 8), // Spacing between icon and text
          Flexible(
            child: Text(
              message,
              style: AppStyle.textBody1Reg.copyWith(
                color: AppColors.white, // White text
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
///     content: FailureToast(message: "An error occurred. Please try again."),
///     backgroundColor: Colors.transparent, // Transparent background for custom styling
///     elevation: 0,
///     behavior: SnackBarBehavior.floating,
///   ),
/// );
/// ```