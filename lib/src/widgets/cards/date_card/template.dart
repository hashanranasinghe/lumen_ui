import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable date display card with tap functionality.
/// 
/// This widget creates a pill-shaped card that displays a selected date and
/// responds to user taps. It's commonly used in date selection interfaces,
/// calendar views, or as a date filter selector in applications.
/// 
/// The card has a clean, minimal design with rounded corners and can be
/// styled with custom colors, dimensions, and text formatting.
/// 
/// 
/// ### Parameters:
/// - [selectedDate] (required): The date string to display inside the card.
/// - [onPress] (required): Function called when the card is tapped.
/// - [width]: Width of the card. Default is `185.0`.
/// - [height]: Height of the card. Default is `39.0`.
/// - [backgroundColor]: Background color of the card. Default is `AppColors.lightGray`.
/// - [textColor]: Color of the date text. Default is `AppColors.white`.
/// - [borderRadius]: Corner radius of the card. Default is `50.0`.
/// - [textStyle]: Text style for the date display. If not provided, defaults to color [textColor].
/// - [elevation]: Shadow elevation of the card. Default is `2.0`.
class Template extends StatelessWidget {
  final String selectedDate;
  final VoidCallback onPress;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final double elevation;

  const Template({
    Key? key,
    required this.selectedDate,
    required this.onPress,
    this.width = 185.0,
    this.height = 39.0,
    this.backgroundColor = AppColors.lightGray,
    this.textColor = AppColors.white,
    this.borderRadius = 50.0,
    this.textStyle,
    this.elevation = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default text style if not provided
    final TextStyle effectiveTextStyle = textStyle ?? 
        TextStyle(
          color: textColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        );

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Calendar icon for visual clarity
                Icon(
                  Icons.calendar_today_rounded,
                  size: 16.0,
                  color: effectiveTextStyle.color,
                ),
                const SizedBox(width: 8.0),
                // Date text
                Text(
                  selectedDate,
                  style: effectiveTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ### Example Usage:
/// ```dart
/// String _currentDate = "May 19, 2025";
/// 
/// DateCard(
///   selectedDate: _currentDate,
///   onPress: () async {
///     // Show date picker and update date when selected
///     final DateTime? picked = await showDatePicker(
///       context: context,
///       initialDate: DateTime.now(),
///       firstDate: DateTime(2020),
///       lastDate: DateTime(2030),
///     );
///     
///     if (picked != null) {
///       setState(() {
///         _currentDate = "${picked.day}/${picked.month}/${picked.year}";
///       });
///     }
///   },
///   backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
///   textColor: Theme.of(context).primaryColor,
/// )
/// ```
/// 
/// ### Variations:
/// 
/// #### Selected state
/// ```dart
/// DateCard(
///   selectedDate: "Today",
///   onPress: () {},
///   backgroundColor: Theme.of(context).primaryColor,
///   textColor: Colors.white,
///   elevation: 4.0,
/// )
/// ```
/// 
/// #### Custom styling
/// ```dart
/// DateCard(
///   selectedDate: "May 2025",
///   onPress: () {},
///   width: 150.0,
///   height: 45.0, 
///   backgroundColor: Colors.grey[200]!,
///   textStyle: TextStyle(
///     color: Colors.black87,
///     fontWeight: FontWeight.bold,
///     fontSize: 16.0,
///   ),
///   borderRadius: 12.0,
/// )
/// ```