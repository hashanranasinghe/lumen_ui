import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A versatile card component for Flutter applications.
///
/// This reusable card widget supports various content layouts with customizable
/// header, body, and footer sections. It provides consistent styling while
/// allowing extensive customization.
class Template extends StatelessWidget {
  /// The title displayed in the header section.
  final String? title;

  /// Optional subtitle displayed beneath the title.
  final String? subtitle;

  /// The main content widget displayed in the body of the card.
  final Widget? content;

  /// Optional widget displayed at the bottom of the card.
  final Widget? footer;

  /// Background color of the card.
  /// Defaults to the theme's surface color.
  final Color? backgroundColor;

  /// The border radius of the card corners.
  /// Defaults to `12.0`.
  final double borderRadius;

  /// Padding applied to the card's content.
  /// Defaults to `EdgeInsets.all(16.0)`.
  final EdgeInsetsGeometry padding;

  /// The elevation that controls the size of the shadow below the card.
  /// Defaults to `2.0`.
  final double elevation;

  /// Whether the card should expand to fill its parent width.
  /// Defaults to `true`.
  final bool expandWidth;

  /// Optional border to apply to the card.
  final BoxBorder? border;

  /// Optional click handler for the entire card.
  final VoidCallback? onTap;

  /// Creates a LumenCard with customizable header, content, and footer.
  const Template({
    Key? key,
    this.title,
    this.subtitle,
    this.content,
    this.footer,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation = 2.0,
    this.expandWidth = true,
    this.border,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultCardColor = backgroundColor ?? AppColors.surface;
    const titleColor = AppColors.onSurface;
    const subtitleColor = AppColors.onSurfaceVariant;
    
    Widget cardContent = Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildCardChildren(titleColor, subtitleColor),
      ),
    );

    final card = Card(
      elevation: elevation,
      color: defaultCardColor,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: border != null 
            ? BorderSide(color: (border as Border).top.color) 
            : BorderSide.none,
      ),
      child: cardContent,
    );

    // If onTap is provided, wrap with InkWell for tap feedback
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    // Apply width constraints if needed
    if (!expandWidth) {
      return IntrinsicWidth(child: card);
    }

    return card;
  }

  /// Builds the card's internal widget structure
  List<Widget> _buildCardChildren(Color titleColor, Color subtitleColor) {
    final List<Widget> children = [];
    
    // Header section (title and subtitle)
    if (title != null) {
      children.add(Text(
        title!,
        style: AppStyle.textHeadline5Reg.copyWith(color: titleColor),
      ));
    }
    
    if (subtitle != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subtitle!,
          style: AppStyle.textSubtitle1Reg.copyWith(color: subtitleColor),
        ),
      ));
    }
    
    // Add spacing between header and content
    if ((title != null || subtitle != null) && content != null) {
      children.add(const SizedBox(height: 12));
    }
    
    // Main content
    if (content != null) {
      children.add(content!);
    }
    
    // Footer with spacing
    if (footer != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: footer!,
      ));
    }
    
    return children;
  }
}