import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable icon card with text label and tap functionality.
///
/// This widget creates a rounded card containing an icon with a circular
/// background and a text label underneath. It's designed for menus, feature grids,
/// or action buttons in applications.
///
/// The card provides visual feedback on tap through splash and highlight effects,
/// and can be customized with different colors and content.
///
/// ### Parameters:
/// - [onTap] (required): Function called when the card is tapped.
/// - [text] (required): The text label to display below the icon.
/// - [icon] (required): The icon to display in the card.
/// - [iconColor]: Color of the icon. Default is `AppColors.primary`.
/// - [backgroundColor]: Background color of the icon circle. Defaults to [iconColor] with opacity.
/// - [textColor]: Color of the text label. Default is `AppColors.appPrimary`.
/// - [padding]: Padding around the entire card content. Default is `EdgeInsets.all(12)`.
/// - [iconSize]: Size of the icon. Default is `25.0`.
/// - [textStyle]: Text style for the label. If not provided, defaults using [textColor].
/// - [borderRadius]: Corner radius of the card. Default is `16.0`.
/// - [horizontalPadding]: Left padding from screen edge. If null, uses responsive calculation.
class Template extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final TextStyle? textStyle;
  final double borderRadius;
  final double? horizontalPadding;

  const Template({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.textColor = AppColors.appPrimary,
    this.padding = const EdgeInsets.all(12),
    this.iconSize = 25.0,
    this.textStyle,
    this.borderRadius = 16.0,
    this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive padding if horizontalPadding is not provided
    final size = MediaQuery.of(context).size;
    final effectiveHorizontalPadding = horizontalPadding ?? size.width * 0.09;

    // Use provided text style or create default
    final TextStyle effectiveTextStyle = textStyle ??
        TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );

    // Determine effective icon color with fallback
    final Color effectiveIconColor = iconColor ?? AppColors.primary;

    // Determine background color (either provided or derived from icon color)
    final Color effectiveBackgroundColor =
        backgroundColor ?? effectiveIconColor.withOpacity(0.1);

    return Row(
      mainAxisSize: MainAxisSize.min, // Adjust row size to content
      children: [
        Padding(
          padding: EdgeInsets.only(left: effectiveHorizontalPadding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: AppColors.primary.withOpacity(0.1),
                highlightColor: AppColors.primary.withOpacity(0.05),
                child: Padding(
                  padding: padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, // Keep column tight
                    children: [
                      // Icon with circular background
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: effectiveBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: effectiveIconColor,
                          size: iconSize,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Text label
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: effectiveTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ### Example Usage:
/// ```dart
/// IconCard(
///   icon: Icons.settings,
///   text: "Settings",
///   onTap: () {
///     Navigator.push(
///       context,
///       MaterialPageRoute(builder: (context) => SettingsScreen()),
///     );
///   },
///   iconColor: Theme.of(context).primaryColor,
/// )
/// ```
///
/// ### Variations:
///
/// #### Feature menu item
/// ```dart
/// IconCard(
///   icon: Icons.movie,
///   text: "Entertainment",
///   onTap: () {},
///   iconColor: Colors.purple,
///   backgroundColor: Colors.purple.withOpacity(0.15),
///   iconSize: 30,
///   textStyle: TextStyle(
///     fontSize: 14,
///     fontWeight: FontWeight.bold,
///   ),
/// )
/// ```
///
/// #### Action button
/// ```dart
/// IconCard(
///   icon: Icons.add_shopping_cart,
///   text: "Add to Cart",
///   onTap: () {
///     // Add product to cart
///     cartController.addItem(product);
///     ScaffoldMessenger.of(context).showSnackBar(
///       SnackBar(content: Text("Added to cart")),
///     );
///   },
///   iconColor: Colors.green,
///   padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
///   borderRadius: 8.0,
/// )
/// ```
