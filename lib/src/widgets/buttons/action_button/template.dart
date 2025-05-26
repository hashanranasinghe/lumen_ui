
import 'package:flutter/material.dart';
/// A customizable action button widget with tooltip and visual feedback.
/// 
/// This widget creates a small, touch-friendly action button with an icon,
/// tooltip, and customizable appearance. It's designed for use in app bars,
/// list items, or any interface where compact action buttons are needed.
///
/// ### Parameters:
/// - [icon] (required): Icon to display inside the button.
/// - [tooltip] (required): Text shown when the user long-presses the button.
/// - [onPressed] (required): Function called when button is tapped.
/// - [color] (required): Primary color used for the icon and background.
/// - [size]: Size of the icon. Default is `20.0`.
/// - [padding]: Padding inside the button. Default is `8.0`.
/// - [borderRadius]: Corner radius of the button. Default is `4.0`.
/// - [backgroundOpacity]: Opacity of the background color. Default is `0.12`.
/// - [splashColor]: Color of the splash effect when pressed. Defaults to [color].
/// - [tooltipVerticalOffset]: Vertical offset of the tooltip. Default is `24.0`.
/// - [tooltipShowDuration]: Duration for tooltip to remain visible. Default is `1.5` seconds.
class Template extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final double padding;
  final double borderRadius;
  final double backgroundOpacity;
  final Color? splashColor;
  final double tooltipVerticalOffset;
  final Duration tooltipShowDuration;

  const Template({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.color,
    this.size = 20.0,
    this.padding = 8.0,
    this.borderRadius = 4.0,
    this.backgroundOpacity = 0.12,
    this.splashColor,
    this.tooltipVerticalOffset = 24.0,
    this.tooltipShowDuration = const Duration(seconds: 1, milliseconds: 500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the total button size including padding
    final double totalSize = size + (padding * 2);
    
    return SizedBox(
      width: totalSize,
      height: totalSize,
      child: Tooltip(
        message: tooltip,
        verticalOffset: tooltipVerticalOffset,
        showDuration: tooltipShowDuration,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: splashColor ?? color.withOpacity(0.3),
            child: Ink(
              decoration: BoxDecoration(
                color: color.withOpacity(backgroundOpacity),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Icon(
                  icon,
                  size: size,
                  color: color,
                ),
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
/// Simple delete action button
/// ActionButton(
///   icon: Icons.delete_outline,
///   tooltip: 'Delete item',
///   onPressed: () => deleteItem(itemId),
///   color: Colors.red,
/// )
/// 
/// Custom sized edit action button
/// ActionButton(
///   icon: Icons.edit,
///   tooltip: 'Edit details',
///   onPressed: () => navigateToEdit(item),
///   color: Theme.of(context).primaryColor,
///   size: 24.0,
///   padding: 10.0, 
///   borderRadius: 8.0,
/// )