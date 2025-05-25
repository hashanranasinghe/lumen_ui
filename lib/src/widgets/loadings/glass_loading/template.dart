import 'dart:ui';
import 'package:flutter/cupertino.dart';

/// A stylish glassmorphism-style loading indicator with optional message display.
///
/// This widget displays a pulsing, frosted glass container with a centered
/// Cupertino-style activity indicator. It uses a blurred backdrop filter
/// combined with semi-transparent layers and subtle shadows to achieve the
/// glass effect.
///
///
/// ### Features:
/// - Pulsing scale animation that smoothly animates the container size.
/// - Frosted glass effect using `BackdropFilter` with blur and gradient overlay.
/// - Rounded corners with semi-transparent borders and shadows.
/// - Optional message text shown below the loading spinner.
///
///
/// ### Parameters:
/// - [message]: Optional message text displayed below the loader.
/// - [size]: Diameter of the glass container. Default is 80.0.
/// - [showMessage]: Whether to display the message text. Default is false.
///

class Template extends StatefulWidget {
  final String? message;
  final double size;
  final bool showMessage;

  const Template({
    super.key,
    this.message,
    this.size = 80,
    this.showMessage = false,
  });

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Animation controller for continuous pulsing effect
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Tween animation from scale 0.8 to 1.0 with easeInOut curve
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Repeat animation indefinitely, reversing on each cycle
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose animation controller to free resources
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated pulsing glass container with blur and shadows
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(widget.size * 0.2),
                    border: Border.all(
                      color: CupertinoColors.separator.withOpacity(0.3),
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.size * 0.2),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              CupertinoColors.white.withOpacity(0.2),
                              CupertinoColors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: Center(
                          child: CupertinoActivityIndicator(
                            radius: widget.size * 0.18,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Optional message text shown below the glass loader
          if (widget.showMessage && widget.message != null) ...[
            const SizedBox(height: 16),
            Text(
              widget.message!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: CupertinoColors.secondaryLabel,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
///
/// ### Example usage:
/// ```dart
/// GlassLoadingTemplate(
///   size: 100,
///   message: "Loading...",
///   showMessage: true,
/// )
/// ```