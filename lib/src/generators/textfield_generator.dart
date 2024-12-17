import 'dart:io';
import 'package:path/path.dart' as path;
import 'base_generator.dart';

class TextFieldGenerator extends BaseGenerator {
  @override
  Future<void> generate({
    required String name,
    required String outputDirectory,
  }) async {
    // Validate component name
    if (!isValidComponentName(name)) {
      throw ArgumentError('Invalid textfield name: $name');
    }

    // Determine file path
    final fileName = '${name.toLowerCase()}_textfield.dart';
    final filePath = path.join(outputDirectory, 'text_fields', fileName);

    // Generate textfield template
    final textFieldContent = _generateTextFieldTemplate(name);

    // Create file
    await createFile(path: filePath, content: textFieldContent);
  }

  String _generateTextFieldTemplate(String name) {
    return '''
import 'package:flutter/material.dart';

class ${_capitalize(name)}TextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;

  const ${_capitalize(name)}TextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: '${_capitalize(name)} Input',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
''';
  }

  // Utility method to capitalize first letter
  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}