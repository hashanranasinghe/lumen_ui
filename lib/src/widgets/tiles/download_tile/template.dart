import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

// A tile widget to display downloadable items with title, subtitle, icon, and a download button.
class Template extends StatefulWidget {
  final Function() onDownload; // Callback when download button is pressed
  final String title; // Title text
  final String subtitle; // Subtitle text
  final IconData? leadingIcon; // Optional leading icon
  final bool isDownloading; // Indicates if currently downloading
  final double? progress; // Download progress (0.0 to 1.0)

  const Template({
    super.key,
    required this.onDownload,
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.isDownloading = false,
    this.progress,
  });

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _animationController; // Controls the scaling animation
  late Animation<double> _scaleAnimation; // Animation for button press feedback
  bool _isPressed = false; // Tracks button press state

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose(); // Always dispose of controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top section with icon, title, subtitle, and download button
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          if (widget.leadingIcon != null) ...[
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.appPrimary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                widget.leadingIcon,
                                color: AppColors.appPrimary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title text
                                Text(
                                  widget.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.textBody2Med.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Subtitle text
                                Text(
                                  widget.subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.textBody2Light.copyWith(
                                    fontSize: 13,
                                    color: AppColors.lightGray,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildDownloadButton(), // Right-hand download button
                        ],
                      ),
                    ),
                    // Download progress bar (only if downloading)
                    if (widget.isDownloading && widget.progress != null)
                      _buildProgressBar(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Builds the download button with press feedback and animation
  Widget _buildDownloadButton() {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward(); // Start scale animation
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse(); // Reset animation
        widget.onDownload(); // Trigger download callback
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse(); // Reset on cancel
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: widget.isDownloading
              ? Colors.grey[300]
              : (_isPressed
                  ? AppColors.appPrimary.withOpacity(0.8)
                  : AppColors.appPrimary),
          borderRadius: BorderRadius.circular(12),
          boxShadow: widget.isDownloading
              ? null
              : [
                  BoxShadow(
                    color: AppColors.appPrimary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: widget.isDownloading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(
                Icons.download_outlined,
                color: Colors.white,
                size: 24,
              ),
      ),
    );
  }

  // Displays a thin linear progress bar at the bottom of the tile
  Widget _buildProgressBar() {
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(
          value: widget.progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.appPrimary),
        ),
      ),
    );
  }
}
//
// Usage example:
// DownloadTile(
//   title: "File Name",
//   subtitle: "Description",
//   leadingIcon: Icons.file_present,
//   isDownloading: true,
//   progress: 0.5,
//   onDownload: () {
//     // Handle download action
//   },
// )  