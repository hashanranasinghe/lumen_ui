import 'package:flutter/material.dart';

class ButtonName extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle style;
  final Color buttonColor;

  const ButtonName({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.style,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      child: Text(text),
    );
  }
}
