import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
/// This widget creates a rounded card-based menu item commonly used in support screens,
/// language selection screens, or categorized menu lists. It features a circular colored
/// icon container, title text, optional language/subtitle text, and a trailing chevron icon.
/// 
/// The card uses a consistent design with rounded corners and a container background,
/// making it suitable for grouped menu items or support categories.
/// 
/// ### Parameters:
/// - [title] (required): The main title text to display in the card.
/// - [icon] (required): The icon to display in the colored circular container.
/// - [onTap] (required): Function called when the card is tapped.
/// - [color] (required): Background color for the circular icon container.
/// - [language]: Optional secondary text (e.g., language code, subtitle) displayed before the chevron.
class Template extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final String? language;

  final Color color;

  const Template({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.language,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryContainer,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),

        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15), 
          ),
          child: Icon(
            icon,
            color: AppColors.white,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),   
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // Minimize row width to content
          children: [
            language != null
                ? Text(
                    language!,
                    style: const TextStyle(
                      color: AppColors.darkGray,
                      fontSize: 15,
                    ),
                  )
                : Container(), // Empty container when no language text
                
            const SizedBox(width: 5), // Spacing between text and chevron
            
            // Navigation chevron icon
            const Icon(
              Icons.chevron_right,
              color: AppColors.darkGray,
              size: 20,
            ),
          ],
        ),
        
        // Tap handler
        onTap: () => onTap(),
      ),
    );
  }
}

/// ### Example Usage:
/// 
/// #### Basic support card
/// ```dart
/// Supportcard(
///   title: "General Help",
///   icon: Icons.help_outline,
///   color: Colors.blue,
///   onTap: () {
///     Navigator.push(
///       context,
///       MaterialPageRoute(builder: (context) => GeneralHelpScreen()),
///     );
///   },
/// )
/// ```
/// 
/// #### Language selection card
/// ```dart
/// Supportcard(
///   title: "English",
///   icon: Icons.language,
///   color: Colors.green,
///   language: "EN",
///   onTap: () {
///     // Handle language selection
///     _setLanguage('en');
///   },
/// )
/// ```
/// 
/// #### Support category cards
/// ```dart
/// Column(
///   children: [
///     Supportcard(
///       title: "Account Issues",
///       icon: Icons.account_circle,
///       color: Colors.orange,
///       onTap: () => _navigateToAccountSupport(),
///     ),
///     const SizedBox(height: 8),
///     Supportcard(
///       title: "Payment Help",
///       icon: Icons.payment,
///       color: Colors.purple,
///       language: "FAQ",
///       onTap: () => _navigateToPaymentFAQ(),
///     ),
///     const SizedBox(height: 8),
///     Supportcard(
///       title: "Technical Support",
///       icon: Icons.build,
///       color: Colors.red,
///       onTap: () => _contactTechnicalSupport(),
///     ),
///   ],
/// )
/// ```
/// 
/// #### Custom styled cards with different colors
/// ```dart
/// Supportcard(
///   title: "Premium Support",
///   icon: Icons.star,
///   color: Colors.amber,
///   language: "24/7",
///   onTap: () {
///     // Handle premium support access
///   },
/// )
/// ```
