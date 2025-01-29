import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

class PrimarytextformfiledTemplate extends StatelessWidget {
  final String label;
  final TextInputType keybordtype;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final double width;
  final TextInputAction textInputAction;
  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;
  const PrimarytextformfiledTemplate({
    this.textInputAction = TextInputAction.none,
    this.hintText = "Text",
    required this.onchange,
    required this.valid,
    required this.save,
    Key? key,
    required this.controller,
    this.label = "Textfiled",
    this.keybordtype = TextInputType.text,
    this.width = 500.00,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: width,
        child: TextFormField(
          textInputAction: textInputAction,
          maxLines: maxLines,
          keyboardType: keybordtype,
          onChanged: onchange,
          onSaved: save,
          controller: controller,
          validator: valid,
          decoration: InputDecoration(
            fillColor: const Color.fromRGBO(251, 251, 251, 0.79),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Color(0xFFE2E5E6), // Change this to your desired color
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Color(0xFFE2E5E6), // Change this to your desired color
                width: 1.0,
              ),
            ),
            label: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.md_theme_light_outline),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}
