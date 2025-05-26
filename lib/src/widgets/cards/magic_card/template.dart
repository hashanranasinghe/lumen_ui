import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A beautiful card with gradient background, icon, and title text.
/// 
/// This widget creates an elegant card with a subtle gradient background,
/// a custom icon, and title text. It's designed for feature highlights,
/// quick action buttons, or category selectors in applications.
/// 
/// The card features a soft 3D shadow effect and responds to user taps
/// with a touch ripple effect.
/// 
/// ### Parameters:
/// - [title] (required): The text to display below the icon.
/// - [onTap] (required): Function called when the card is tapped.
/// - [iconData] (required): The icon to display in the card.
/// - [height]: Height of the card. Default is responsive to screen size (10% of screen height).
/// - [width]: Width of the card. Default is responsive to screen size (28% of screen width).
/// - [borderRadius]: Corner radius of the card. Default is `10.0`.
/// - [iconSize]: Size of the icon. Default is responsive (8% of screen width).
/// - [iconColor]: Color of the icon. Default is `AppColors.primary`.
/// - [titleStyle]: Text style for the title. If not provided, uses a bold variant of the theme's labelLarge.
/// - [padding]: External padding around the card. Default is `EdgeInsets.symmetric(horizontal: 5)`.
/// - [gradientColors]: List of colors for the background gradient. Default is a subtle yellow gradient.
/// - [gradientBegin]: Starting alignment for the gradient. Default is `Alignment.topLeft`.
/// - [gradientEnd]: Ending alignment for the gradient. Default is `Alignment.bottomRight`.
/// - [shadowColor]: Color of the card's shadow. Default is `Colors.grey`.
/// - [shadowOffset]: Offset of the shadow for 3D effect. Default is `Offset(6, 6)`.
/// - [shadowBlurRadius]: Blur radius of the shadow. Default is `12.0`.
class Template extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData iconData;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? iconSize;
  final Color iconColor;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry padding;
  final List<Color> gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final Color shadowColor;
  final Offset shadowOffset;
  final double shadowBlurRadius;

  const Template({
    Key? key,
    required this.title,
    required this.onTap,
    required this.iconData,
    this.height,
    this.width,
    this.borderRadius = 10.0,
    this.iconSize,
    this.iconColor = AppColors.primary,
    this.titleStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
    this.gradientColors = const [
      Color.fromARGB(255, 255, 253, 230),
      Color.fromARGB(255, 255, 252, 238),
    ],
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.shadowColor = Colors.grey,
    this.shadowOffset = const Offset(6, 6),
    this.shadowBlurRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive dimensions
    final size = MediaQuery.of(context).size;
    
    // Determine effective dimensions
    final effectiveHeight = height ?? size.height * 0.1;
    final effectiveWidth = width ?? size.width * 0.28;
    final effectiveIconSize = iconSize ?? size.width * 0.08;
    
    // Default text style based on theme
    final effectiveTitleStyle = titleStyle ?? 
        Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.black.withOpacity(0.8),
        ) ??
        TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppColors.black.withOpacity(0.8),
        );

    return Padding(
      padding: padding,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: effectiveHeight,
            width: effectiveWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  offset: shadowOffset,
                  blurRadius: shadowBlurRadius,
                ),
              ],
              gradient: LinearGradient(
                begin: gradientBegin,
                end: gradientEnd,
                colors: gradientColors,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Icon section
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      iconData,
                      size: effectiveIconSize,
                      color: iconColor,
                    ),
                  ),
                  // Title text with auto-fitting
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      title,
                      style: effectiveTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ### Example Usage:
/// ```dart
/// MagicCard(
///   title: "Weather",
///   iconData: Icons.wb_sunny,
///   onTap: () {
///     Navigator.push(
///       context,
///       MaterialPageRoute(builder: (context) => WeatherScreen()),
///     );
///   },
/// )
/// ```
/// 
/// ### Variations:
/// 
/// #### Colorful category card
/// ```dart
/// MagicCard(
///   title: "Photography",
///   iconData: Icons.camera_alt,
///   onTap: () {},
///   gradientColors: [
///     Colors.blue.shade100,
///     Colors.blue.shade200,
///   ],
///   iconColor: Colors.blue.shade700,
///   titleStyle: TextStyle(
///     color: Colors.blue.shade900,
///     fontWeight: FontWeight.bold,
///   ),
/// )
/// ```
/// 
/// #### Action button with custom shadow
/// ```dart
/// MagicCard(
///   title: "Add to Cart",
///   iconData: Icons.shopping_cart,
///   onTap: () {
///     // Add product to cart
///     cartController.addItem(product);
///   },
///   gradientColors: [
///     Colors.green.shade50,
///     Colors.green.shade100,
///   ],
///   iconColor: Colors.green,
///   shadowColor: Colors.green.withOpacity(0.3),
///   shadowOffset: const Offset(4, 4),
///   shadowBlurRadius: 8.0,
///   width: 120,
///   height: 100,
/// )
/// ```