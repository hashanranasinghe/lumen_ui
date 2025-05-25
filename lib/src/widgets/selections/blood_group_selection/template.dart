import 'package:flutter/material.dart';

/// A dropdown widget that allows users to select a blood group from a predefined list.
///
/// This widget accepts a `selectedGroup` string to show the currently selected option,
/// and a `onChange` callback that is triggered whenever a new blood group is selected.
class Template extends StatefulWidget {
  final Function(String) onChange; // Callback when a blood group is selected
  final String selectedGroup; // Initially selected blood group

  Template({
    Key? key,
    required this.onChange,
    required this.selectedGroup,
  }) : super(key: key);

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  // List of blood group options
  final List<String> bloodGroups = [
    'A positive (A+)',
    'A negative (A-)',
    'B positive (B+)',
    'B negative (B-)',
    'AB positive (AB+)',
    'AB negative (AB-)',
    'O positive (O+)',
    'O negative (O-)',
  ];

  // Currently selected item
  String? _selectedItem = null;

  @override
  void initState() {
    // Initialize the selected item from widget parameter
    _selectedItem = widget.selectedGroup == '' ? null : widget.selectedGroup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonFormField<String>(
        value: _selectedItem,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedItem = newValue;
            });
            widget.onChange(newValue); // Call the callback
          }
        },
        decoration: InputDecoration(
          fillColor:
              const Color.fromRGBO(251, 251, 251, 0.79), // Light fill color
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Color(0xFFE2E5E6),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Color(0xFFE2E5E6),
              width: 1.0,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        hint: const Text('Select Blood Group'),
        items: bloodGroups.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

///
/// ### Example Usage:
/// ```dart
/// Bloodgroupselection(
///   selectedGroup: '',
///   onChange: (selectedGroup) {
///     print("Selected blood group: $selectedGroup");
///   },
/// )
/// ```
