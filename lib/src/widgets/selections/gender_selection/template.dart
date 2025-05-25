import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
/// A simple radio-button-based gender selection widget.
///
/// It allows the user to choose between 'Male' and 'Female', and notifies the parent
/// widget via a callback (`onChange`) whenever the selected gender changes.
class Template extends StatefulWidget {
  final Function(String) onChange; // Callback when a gender is selected
  final String selectedGender; // Initially selected gender

  const Template({
    super.key,
    required this.onChange,
    required this.selectedGender,
  });

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Select Gender'),
        // Radio option for 'Male'
        RadioListTile(
          activeColor: AppColors.appPrimary, // Active color for selected option
          title: Text('Male'),
          value: 'Male', // Value associated with this option
          groupValue: widget.selectedGender, // Currently selected gender
          onChanged: (value) {
            widget.onChange(value!); // Trigger callback when selected
          },
        ),
        // Radio option for 'Female'
        RadioListTile(
          activeColor: AppColors.appPrimary,
          title: Text('Female'),
          value: 'Female',
          groupValue: widget.selectedGender,
          onChanged: (value) {
            widget.onChange(value!);
          },
        ),
      ],
    );
  }
}

///
/// ### Example Usage:
/// ```dart
/// Genderselection(
///   selectedGender: 'Male',
///   onChange: (selected) {
///     print("Selected gender: $selected");
///   },
/// )
/// ```
