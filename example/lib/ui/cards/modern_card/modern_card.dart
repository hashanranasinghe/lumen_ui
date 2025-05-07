import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';
import 'package:example/ui/styles/styles.dart';

/// A modern, customizable card widget with a clean layout for
/// title, subtitle, content, and footer sections.
///
/// Designed for general-purpose display of structured content, this card
/// supports visual consistency, adaptive styling, and interactive behavior.
///
/// ### Parameters:
/// - [title]: Primary heading at the top of the card.
/// - [subtitle]: Optional subheading below the title.
/// - [content]: Main body text inside the card.
/// - [footer]: Optional widget placed at the bottom (e.g. buttons).
/// - [backgroundColor]: Background color of the card. Defaults to `AppColors.surface`.
/// - [borderRadius]: Rounding of the card’s corners. Default is `16.0`.
/// - [padding]: Internal padding. Default is `EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0)`.
/// - [elevation]: Shadow level. Default is `1.5`.
/// - [expandWidth]: If `true`, card takes full width. If `false`, wraps content.
/// - [border]: Optional border for outlining the card.
/// - [onTap]: Optional tap callback for the whole card.
///
/// ### Example Usage:
/// ```dart
/// ModernCard(
///   title: "Flutter 3.22 Released",
///   subtitle: "May 7, 2025",
///   content: "The latest version of Flutter introduces performance improvements and new Material 3 widgets.",
///   footer: Row(
///     children: [Icon(Icons.thumb_up, size: 16), SizedBox(width: 6), Text("240 likes")],
///   ),
///   onTap: () => print("Card tapped"),
/// )
/// ```
class ModernCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? content;
  final Widget? footer;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final bool expandWidth;
  final BoxBorder? border;
  final VoidCallback? onTap;

  const ModernCard({
    Key? key,
    this.title,
    this.subtitle,
    this.content,
    this.footer,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
    this.elevation = 1.5,
    this.expandWidth = true,
    this.border,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultCardColor = backgroundColor ?? AppColors.surface;

    Widget cardContent = Container(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildCardChildren(),
      ),
    );

    final cardWidget = Container(
      decoration: BoxDecoration(
        color: defaultCardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: elevation * 4,
            spreadRadius: elevation / 2,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      ),
    );

    final cardWithGesture = GestureDetector(
      onTap: onTap,
      child: cardWidget,
    );

    if (!expandWidth) {
      return IntrinsicWidth(child: cardWithGesture);
    }

    return cardWithGesture;
  }

  /// Builds the internal structure of the card widget.
  List<Widget> _buildCardChildren() {
    final List<Widget> children = [];

    // Header section
    if (title != null) {
      children.add(Text(
        title!,
        style: AppStyle.textHeadline5Reg.copyWith(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ));
    }

    if (subtitle != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(
          subtitle!,
          style: AppStyle.textSubtitle1Reg.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ));
    }

    // Spacing between header and body
    if ((title != null || subtitle != null) && content != null) {
      children.add(const SizedBox(height: 14));
    }

    // Main content
    if (content != null) {
      children.add(Text(
        content!,
        style: TextStyle(
          color: AppColors.onSurface.withOpacity(0.85),
          height: 1.5,
        ),
      ));
    }

    // Footer section
    if (footer != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: footer!,
      ));
    }

    return children;
  }
}
