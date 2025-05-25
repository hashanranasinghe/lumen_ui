import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable history item card with tap functionality.
/// 
/// This widget creates a rounded card that displays history items such as
/// recent searches, viewed items, or activity logs, and responds to user taps.
/// It's designed for history lists, recents sections, or activity timelines
/// in applications.
/// 
/// The card features a clean design with customizable appearance and includes
/// an optional icon and timestamp display.
/// 
/// ### Parameters:
/// - [title] (required): The main text to display inside the card.
/// - [onPress] (required): Function called when the card is tapped.
/// - [subtitle]: Optional secondary text (often timestamp or description).
/// - [leadingIcon]: Icon to display before the title. Default is `Icons.history`.
/// - [width]: Width of the card. Default is `double.infinity` (full width).
/// - [height]: Height of the card. Default is `65.0`.
/// - [backgroundColor]: Background color of the card. Default is `AppColors.cardBackground`.
/// - [textColor]: Color of the text. Default is `AppColors.textPrimary`.
/// - [borderRadius]: Corner radius of the card. Default is `12.0`.
/// - [titleStyle]: Text style for the main text. If not provided, defaults using [textColor].
/// - [subtitleStyle]: Text style for the subtitle. If not provided, uses a lighter variant of [textColor].
/// - [elevation]: Shadow elevation of the card. Default is `1.0`.
/// - [padding]: Internal padding of the card. Default is `EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)`.
class Template extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final String? subtitle;
  final IconData leadingIcon;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double elevation;
  final EdgeInsetsGeometry padding;

  const Template({
    Key? key,
    required this.title,
    required this.onPress,
    this.subtitle,
    this.leadingIcon = Icons.history,
    this.width,
    this.height = 65.0,
    this.backgroundColor = AppColors.white, // Using white as default, replace with AppColors.cardBackground
    this.textColor = AppColors.black, // Using black87 as default, replace with AppColors.textPrimary
    this.borderRadius = 12.0,
    this.titleStyle,
    this.subtitleStyle,
    this.elevation = 1.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default title style if not provided
    final TextStyle effectiveTitleStyle = titleStyle ?? 
        TextStyle(
          color: textColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        );
    
    // Default subtitle style if not provided
    final TextStyle effectiveSubtitleStyle = subtitleStyle ?? 
        TextStyle(
          color: textColor.withOpacity(0.7),
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
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
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                // Leading icon
                Icon(
                  leadingIcon,
                  size: 22.0,
                  color: effectiveTitleStyle.color,
                ),
                const SizedBox(width: 12.0),
                // Content section with title and optional subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: subtitle != null 
                        ? MainAxisAlignment.center 
                        : MainAxisAlignment.center,
                    children: [
                      // Title text
                      Text(
                        title,
                        style: effectiveTitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Subtitle text (if provided)
                      if (subtitle != null) ...[
                        const SizedBox(height: 4.0),
                        Text(
                          subtitle!,
                          style: effectiveSubtitleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                // Trailing chevron icon for navigation indication
                Icon(
                  Icons.chevron_right,
                  size: 20.0,
                  color: effectiveTitleStyle.color!.withOpacity(0.5),
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
/// HistoryCard(
///   title: "Previous search: Flutter widgets",
///   subtitle: "May 20, 2025 • 10:30 AM",
///   onPress: () {
///     // Navigate to search results or perform action
///     Navigator.push(
///       context,
///       MaterialPageRoute(
///         builder: (context) => SearchResultsPage(query: "Flutter widgets"),
///       ),
///     );
///   },
///   leadingIcon: Icons.search,
/// )
/// ```
/// 
/// ### Variations:
/// 
/// #### Recent document
/// ```dart
/// HistoryCard(
///   title: "Project Proposal.pdf",
///   subtitle: "Opened yesterday",
///   onPress: () {},
///   leadingIcon: Icons.insert_drive_file,
///   backgroundColor: Colors.blue.withOpacity(0.1),
///   textColor: Colors.blue.shade800,
/// )
/// ```
/// 
/// #### Activity log item
/// ```dart
/// HistoryCard(
///   title: "Payment processed",
///   subtitle: "$49.99 • 2 hours ago",
///   onPress: () {},
///   leadingIcon: Icons.payment,
///   height: 75.0,
///   borderRadius: 8.0,
///   titleStyle: TextStyle(
///     fontWeight: FontWeight.bold,
///     fontSize: 17.0,
///   ),
/// )
/// ```