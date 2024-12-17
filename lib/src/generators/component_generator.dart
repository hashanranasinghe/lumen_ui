import 'dart:io';
import 'package:path/path.dart' as path;

class ComponentGenerator {
  // Supported component types with their default directory
  static const Map<String, String> componentTypes = {
    'button': 'buttons',
    'textfield': 'text_fields',
    'card': 'cards',
    'dialog': 'dialogs',
  };

  // Generate a component based on type and name
  static void generateComponent({
    required String type, 
    required String name
  }) {
    // Validate component type
    if (!componentTypes.containsKey(type.toLowerCase())) {
      throw ArgumentError('Unsupported component type: $type');
    }

    // Determine target directory
    final targetDir = _determineTargetDirectory(type);
    
    // Create component file
    _createComponentFile(
      directory: targetDir, 
      type: type, 
      name: name
    );
  }

  // Determine the target directory for the component
  static String _determineTargetDirectory(String type) {
    final baseDir = path.join(Directory.current.path, 'lib', 'ui');
    final typeDir = componentTypes[type.toLowerCase()]!;
    final targetDir = path.join(baseDir, typeDir);

    // Create directory if it doesn't exist
    Directory(targetDir).createSync(recursive: true);
    return targetDir;
  }

  // Create the actual component file
  static void _createComponentFile({
    required String directory, 
    required String type, 
    required String name
  }) {
    final fileName = '${name.toLowerCase()}_${type.toLowerCase()}.dart';
    final filePath = path.join(directory, fileName);

    // Check if file already exists
    if (File(filePath).existsSync()) {
      throw StateError('Component $fileName already exists');
    }

    // Generate file content based on type
    final fileContent = _generateComponentContent(
      type: type, 
      name: name
    );

    // Write file
    File(filePath).writeAsStringSync(fileContent);
    print('Generated $fileName in $directory');
  }

  // Generate component content based on type
  static String _generateComponentContent({
    required String type, 
    required String name
  }) {
    switch (type.toLowerCase()) {
      case 'button':
        return _generateButtonComponent(name);
      case 'textfield':
        return _generateTextFieldComponent(name);
      default:
        throw UnsupportedError('No template for $type');
    }
  }

  // Button component template
  static String _generateButtonComponent(String name) {
    return '''
import 'package:flutter/material.dart';

class ${_capitalize(name)}Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const ${_capitalize(name)}Button({
    Key? key,
    required this.text,
    this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(
        // Add your custom styling here
      ),
      child: Text(text),
    );
  }
}
''';
  }

  // TextField component template
  static String _generateTextFieldComponent(String name) {
    return '''
import 'package:flutter/material.dart';

class ${_capitalize(name)}TextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;

  const ${_capitalize(name)}TextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        // Add your custom decoration here
      ),
    );
  }
}
''';
  }

  // Utility method to capitalize first letter
  static String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}

// Alias function for easier import
void generateComponent({
  required String type, 
  required String name
}) {
  ComponentGenerator.generateComponent(type: type, name: name);
}