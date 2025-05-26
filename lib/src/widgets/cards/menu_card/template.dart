import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A customizable menu item card with icon, title, optional count badge, and divider.
/// 
/// This widget creates a row-based menu item commonly used in settings screens,
/// navigation drawers, or list menus. It features a leading icon image,
/// a title, an optional count badge, and a trailing chevron icon.
/// 
/// The card can optionally display a divider line below it to separate it from
/// subsequent menu items, creating a clean list appearance.
/// 
/// ### Parameters:
/// - [leadingIcon] (required): Leading icon.
/// - [title] (required): The title text to display.
/// - [onTap] (required): Function called when the menu item is tapped.
/// - [subCount]: Optional count or notification number to display in a badge.
/// - [isShowBottomLine]: Whether to show a divider line below the menu item. Default is `true`.
/// - [backgroundColor]: Background color of the menu item. Default is `Colors.white`.
/// - [titleStyle]: Text style for the title. If not provided, uses default style.
/// - [badgeBackgroundColor]: Background color of the count badge. Default is a semitransparent `AppColors.lightGray`.
/// - [badgeTextStyle]: Text style for the count badge. Default is `AppStyle.textBody2Light`.
/// - [iconSize]: Size of the leading icon. Default is `24.0`.
/// - [chevronIcon]: Icon to display on the right side. Default is `Icons.keyboard_arrow_right`.
/// - [chevronColor]: Color of the chevron icon. Default is `Colors.grey`.
/// - [padding]: Padding for the menu item content. Default is `EdgeInsets.symmetric(vertical: 15.0)`.
/// - [dividerColor]: Color of the bottom divider line. Default is `AppColors.primary`.
/// - [dividerIndent]: Starting indent of the divider. Default is `25.0`.
/// - [dividerEndIndent]: Ending indent of the divider. Default is `25.0`.
/// - [dividerThickness]: Thickness of the divider line. Default is `1.5`.
class Template extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String? subCount;
  final VoidCallback onTap;
  final bool isShowBottomLine;
  final Color backgroundColor;
  final TextStyle? titleStyle;
  final Color badgeBackgroundColor;
  final TextStyle? badgeTextStyle;
  final double iconSize;
  final IconData chevronIcon;
  final Color chevronColor;
  final EdgeInsetsGeometry padding;
  final Color dividerColor;
  final double dividerIndent;
  final double dividerEndIndent;
  final double dividerThickness;

  const Template({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
    this.subCount,
    this.isShowBottomLine = true,
    this.backgroundColor = Colors.white,
    this.titleStyle,
    this.badgeBackgroundColor = const Color(0x00000000), // Transparent as placeholder
    this.badgeTextStyle,
    this.iconSize = 24.0,
    this.chevronIcon = Icons.keyboard_arrow_right,
    this.chevronColor = Colors.grey,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
    this.dividerColor = AppColors.primary,
    this.dividerIndent = 25.0,
    this.dividerEndIndent = 25.0,
    this.dividerThickness = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default text styles
    final effectiveTitleStyle = titleStyle ?? 
        const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        );
        
    // Use provided badge background color or default to AppColors.lightGray with opacity
    final effectiveBadgeBackgroundColor = badgeBackgroundColor != const Color(0x00000000) ? 
        badgeBackgroundColor : 
        AppColors.lightGray.withOpacity(0.8);
    
    // Default badge text style
    final effectiveBadgeTextStyle = badgeTextStyle ?? AppStyle.textBody2Light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: backgroundColor,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: Row(
                children: [
                  // Leading icon
                  Icon(
                    leadingIcon,
                    size: iconSize,
                  ),
                  const SizedBox(width: 15.0),
                  
                  // Title text
                  Text(
                    title,
                    style: effectiveTitleStyle,
                  ),
                  const SizedBox(width: 10.0),
                  
                  // Optional count badge
                  if (subCount != null)
                    CircleAvatar(
                      radius: 13.0,
                      backgroundColor: effectiveBadgeBackgroundColor,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 11.8,
                        child: Center(
                          child: Text(
                            subCount!,
                            style: effectiveBadgeTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  
                  // Spacing to push chevron to the right
                  const Spacer(),
                  
                  // Trailing chevron icon
                  Icon(
                    chevronIcon,
                    color: chevronColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Optional divider line
        if (isShowBottomLine)
          Divider(
            height: dividerThickness,
            thickness: dividerThickness,
            endIndent: dividerEndIndent,
            indent: dividerIndent,
            color: dividerColor,
          ),
      ],
    );
  }
}

/// ### Example Usage:
/// ```dart
/// MenuCard(
///   leadingIcon: "assets/icons/settings.png",
///   title: "Settings",
///   onTap: () {
///     Navigator.push(
///       context,
///       MaterialPageRoute(builder: (context) => SettingsScreen()),
///     );
///   },
/// )
/// ```
/// 
/// ### Variations:
/// 
/// #### Menu item with notification count
/// ```dart
/// MenuCard(
///   leadingIcon: "assets/icons/notifications.png",
///   title: "Notifications",
///   subCount: "3",
///   onTap: () {},
///   badgeBackgroundColor: Colors.red.withOpacity(0.2),
///   badgeTextStyle: TextStyle(
///     color: Colors.red,
///     fontWeight: FontWeight.bold,
///     fontSize: 12.0,
///   ),
/// )
/// ```
/// 
/// #### Last menu item without divider
/// ```dart
/// MenuCard(
///   leadingIcon: "assets/icons/help.png",
///   title: "Help & Support",
///   onTap: () {},
///   isShowBottomLine: false,
///   chevronIcon: Icons.open_in_new,
///   titleStyle: TextStyle(
///     fontWeight: FontWeight.w500,
///     fontSize: 16.0,
///   ),
/// )
/// ```
/// 
/// #### Custom styled menu item
/// ```dart
/// MenuCard(
///   leadingIcon: "assets/icons/premium.png",
///   title: "Upgrade to Premium",
///   onTap: () {},
///   backgroundColor: Colors.amber.withOpacity(0.1),
///   titleStyle: TextStyle(
///     color: Colors.amber.shade800,
///     fontWeight: FontWeight.bold,
///     fontSize: 16.0,
///   ),
///   dividerColor: Colors.amber,
///   chevronColor: Colors.amber.shade800,
/// )
/// ```