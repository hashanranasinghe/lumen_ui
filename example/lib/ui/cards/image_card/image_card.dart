import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';
import 'package:example/ui/styles/styles.dart';

/// A modern, customizable card widget that displays an image,
/// with optional title, subtitle, content, and footer.
///
/// Designed for content previews like articles, products, or profiles,
/// this widget features clean visuals, elevation, and gradient overlay for image readability.
///
/// ### Parameters:
/// - [imageUrl] (required): The image displayed at the top.
/// - [title]: Title below the image.
/// - [subtitle]: Subtitle text under the title.
/// - [content]: Optional body text/content inside the card.
/// - [footer]: A custom widget displayed at the bottom (e.g. buttons or chips).
/// - [backgroundColor]: Card's background color. Default is `AppColors.surface`.
/// - [borderRadius]: Rounding of corners. Default is `16.0`.
/// - [padding]: Internal padding. Default is `EdgeInsets.all(16.0)`.
/// - [elevation]: Elevation shadow level. Default is `2.0`.
/// - [onTap]: Callback when card is tapped.

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? content;
  final Widget? footer;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final VoidCallback? onTap;

  const ImageCard({
    Key? key,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.content,
    this.footer,
    this.backgroundColor = AppColors.surface,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation = 2.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: elevation * 2,
              offset: Offset(0, elevation),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top image with optional gradient overlay
              Stack(
                children: [
                  Image.network(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (title != null || subtitle != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Text content and footer
              Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: AppStyle.textHeadline5Reg.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          subtitle!,
                          style: AppStyle.textSubtitle1Reg.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (content != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          content!,
                          style: TextStyle(
                            color: AppColors.onSurface.withOpacity(0.8),
                          ),
                        ),
                      ),
                    if (footer != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: footer!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
///
/// ### Example Usage:
/// ```dart
/// ImageCard(
///   imageUrl: "https://example.com/cover.jpg",
///   title: "Beautiful Landscape",
///   subtitle: "By John Doe",
///   content: "Explore breathtaking nature scenes in this collection.",
///   footer: Row(
///     children: [Icon(Icons.favorite), Text("100 Likes")],
///   ),
///   onTap: () => print("Card tapped"),
/// )
/// ```