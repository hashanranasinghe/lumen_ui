import 'package:flutter/cupertino.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
/// A customizable loading indicator widget with optional message display.
///
/// This widget shows an animated loading spinner inside a rounded container,
/// featuring a subtle scale and fade-in effect when appearing. It is designed
/// using Cupertino (iOS-style) components for a clean, native look.
///
///
/// ### Features:
/// - Animated scale and fade transition for smooth appearance.
/// - Customizable size of the loading indicator container.
/// - Optional message text displayed below the spinner.
/// - Custom background and indicator colors.
/// - Shadows for a subtle elevation effect.
///
///
/// ### Parameters:
/// - [message]: Optional text message to display below the loading indicator.
/// - [size]: Diameter of the loading indicator container. Default is 80.0.
/// - [backgroundColor]: Background color of the loading container. Defaults to white.
/// - [indicatorColor]: Color of the CupertinoActivityIndicator spinner.
/// - [showMessage]: Whether to show the [message] below the spinner. Default is false.
///

class Template extends StatefulWidget {
  final String? message;
  final double size;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final bool showMessage;

  const Template({
    super.key,
    this.message,
    this.size = 80,
    this.backgroundColor,
    this.indicatorColor,
    this.showMessage = false,
  });

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for scale and fade animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Scale animation from 0.8 to 1.0 with easeOutBack curve for a subtle pop effect
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    // Fade animation from 0 (transparent) to 1 (opaque), starting immediately and lasting 60% of the animation duration
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    // Dispose animation controller when widget is removed
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated loading spinner container with scale and fade animations
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ??
                          CupertinoDynamicColor.resolve(AppColors.white, context),
                      borderRadius: BorderRadius.circular(widget.size * 0.175),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.black.withOpacity(0.08),
                          blurRadius: widget.size * 0.15,
                          spreadRadius: 0,
                          offset: Offset(0, widget.size * 0.05),
                        ),
                        BoxShadow(
                          color: CupertinoColors.black.withOpacity(0.04),
                          blurRadius: widget.size * 0.25,
                          spreadRadius: widget.size * 0.025,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: widget.size * 0.2,
                        color: widget.indicatorColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Optional message text displayed below the spinner with fade animation
          if (widget.showMessage && widget.message != null) ...[
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Text(
                    widget.message!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.secondaryLabel,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
///
/// ### Usage example:
/// ```dart
/// LoadingTemplate(
///   size: 100,
///   backgroundColor: Colors.white,
///   indicatorColor: Colors.blue,
///   message: "Loading data...",
///   showMessage: true,
/// )
/// ```