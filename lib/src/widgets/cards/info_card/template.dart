import 'package:flutter/material.dart';

/// A customizable card to display information with an image and action button.
/// 
/// This widget creates a card with an image, a title, and a "View Info" 
/// action button. It's designed for grid layouts, catalog displays,
/// or information showcase components in applications.
/// 
/// The card features rounded corners with a subtle shadow and responds to
/// user taps with a touch ripple effect.
/// 
/// ### Parameters:
/// - [name] (required): The title text to display below the image.
/// - [onTap] (required): Function called when the card is tapped.
/// - [image] (required): Asset path for the image to display.
/// - [height]: Height of the card. Default is responsive to screen size.
/// - [width]: Width of the card. Default is responsive to screen size.
/// - [backgroundColor]: Background color of the card. Default is `Colors.white`.
/// - [borderRadius]: Corner radius of the card and image. Default is `12.0`.
/// - [elevation]: Shadow elevation of the card. Default is `2.0`.
/// - [padding]: External padding around the card. Default is `EdgeInsets.all(8.0)`.
/// - [actionText]: Text for the action button. Default is "View Info".
/// - [actionIcon]: Icon for the action button. Default is `Icons.open_in_new`.
/// - [titleStyle]: Text style for the title. If not provided, uses theme's subtitle1.
/// - [actionTextStyle]: Text style for the action button text.
/// - [shadowColor]: Color of the card's shadow. Default is `Colors.grey`.
class Template extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final String image;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final String actionText;
  final IconData actionIcon;
  final TextStyle? titleStyle;
  final TextStyle? actionTextStyle;
  final Color shadowColor;

  const Template({
    Key? key,
    required this.name,
    required this.onTap,
    required this.image,
    this.height,
    this.width,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(8.0),
    this.actionText = "View Info",
    this.actionIcon = Icons.open_in_new,
    this.titleStyle,
    this.actionTextStyle,
    this.shadowColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive dimensions
    final size = MediaQuery.of(context).size;
    
    // Determine effective dimensions
    final effectiveHeight = height ?? size.height / 4;
    final effectiveWidth = width ?? size.width / 3;
    
    // Default text styles based on theme
    final effectiveTitleStyle = titleStyle ?? Theme.of(context).textTheme.titleMedium;
    final effectiveActionTextStyle = actionTextStyle ?? 
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        );

    return Padding(
      padding: padding,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: elevation,
        shadowColor: shadowColor,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: effectiveHeight,
            width: effectiveWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Image section with padding and rounded corners
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: Image.asset(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Title section with auto-fitting text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      style: effectiveTitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Action button section
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        actionIcon,
                        size: 16,
                        color: effectiveActionTextStyle.color,
                      ),
                      SizedBox(
                        width: size.width / 45,
                      ),
                      Text(
                        actionText,
                        style: effectiveActionTextStyle,
                      )
                    ],
                  ),
                )
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
/// InfoCard(
///   name: "Mountain Retreat",
///   image: "assets/images/mountain.jpg",
///   onTap: () {
///     Navigator.push(
///       context,
///       MaterialPageRoute(
///         builder: (context) => DetailScreen(id: "mountain_retreat"),
///       ),
///     );
///   },
/// )
/// ```
/// 
/// ### Variations:
/// 
/// #### Product card
/// ```dart
/// InfoCard(
///   name: "Wireless Headphones",
///   image: "assets/images/products/headphones.jpg",
///   onTap: () {},
///   actionText: "Shop Now",
///   actionIcon: Icons.shopping_bag,
///   backgroundColor: Colors.grey[50]!,
///   borderRadius: 8.0,
///   titleStyle: TextStyle(
///     fontWeight: FontWeight.bold,
///     fontSize: 14.0,
///   ),
/// )
/// ```
/// 
/// #### Location card
/// ```dart
/// InfoCard(
///   name: "Paris, France",
///   image: "assets/images/locations/paris.jpg",
///   onTap: () {},
///   actionText: "Explore",
///   actionIcon: Icons.explore,
///   width: 160,
///   height: 200,
///   elevation: 4.0,
///   titleStyle: TextStyle(
///     fontSize: 16.0,
///     fontWeight: FontWeight.w600,
///     color: Colors.indigo,
///   ),
/// )
/// ```