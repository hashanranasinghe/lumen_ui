import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';


/// A customizable button widget that provides a consistent design across the application.
/// 
/// This widget wraps Flutter's ElevatedButton with predefined styling and customization options.
/// It allows for easy modification of colors, padding, text, and click behavior.
/// 
/// Example usage:
/// ```dart
/// ButtonTemplate(
///   text: "Submit",
///   color: Colors.blue,
///   onpress: () {
///     print("Button pressed!");
///   },
/// )
/// ```
class ButtonTemplate extends StatelessWidget {
  /// The background color of the button
  final Color color;

  /// The color of the button's text
  final Color textColor;

  /// The text to display on the button
  final String text;

  /// Left padding of the button content
  final double paddingLeft;

  /// Right padding of the button content
  final double paddingRight;

  /// Top padding of the button content
  final double paddingTop;

  /// Bottom padding of the button content
  final double paddingBottom;

  /// Callback function to execute when the button is pressed
  final VoidCallback onPress;

  /// Font size of the button text
  final double fontSize;

  /// Creates a ButtonTemplate with customizable properties.
  /// 
  /// All parameters except [onPress] have default values:
  /// - [color] defaults to AppColors.blue
  /// - [textColor] defaults to AppColors.white
  /// - [text] defaults to "Button"
  /// - [paddingLeft] and [paddingRight] default to 15
  /// - [paddingTop] and [paddingBottom] default to 10
  /// - [fontSize] defaults to 20
  const ButtonTemplate({
    Key? key,
    this.color = AppColors.blue,
    this.textColor = AppColors.white,
    this.text = "Button",
    this.paddingLeft = 15,
    this.paddingRight = 15,
    this.paddingTop = 10,
    this.paddingBottom = 10,
    required this.onPress,
    this.fontSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1.0,
          backgroundColor: color,
          padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            top: paddingTop,
            bottom: paddingBottom,
          ),
        ),
        child: Text(
          text,
          style: AppStyle.fieldText.copyWith(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}