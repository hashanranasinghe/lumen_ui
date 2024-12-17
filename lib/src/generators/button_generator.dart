import 'dart:io';
import 'package:path/path.dart' as path;
import 'base_generator.dart';

class ButtonGenerator extends BaseGenerator {
  @override
  Future<void> generate({
    required String name,
    required String outputDirectory,
  }) async {
    // Validate component name
    if (!isValidComponentName(name)) {
      throw ArgumentError('Invalid button name: $name');
    }

    // Determine file path
    final fileName = '${name.toLowerCase()}_button.dart';
    final filePath = path.join(outputDirectory, 'buttons', fileName);

    // Generate button template
    final buttonContent = _generateButtonTemplate(name);

    // Create file
    await createFile(path: filePath, content: buttonContent);
  }
  String readButtonTemplate(String name) {
    // Determine the path to the template file
    final templatePath = path.join(
      Directory.current.path, 
      'lib', 'src', 'widgets', 
      'button_template.dart'
    );

    try {
      // Read the template file
      String template = File(templatePath).readAsStringSync();
      template = template.replaceAll('ButtonName', '${_capitalize(name)}Button');
      return template;
    } catch (e) {
      return "Error";
    }
  }

  String _generateButtonTemplate(String name) {
    return readButtonTemplate(name);
  }

  // Utility method to capitalize first letter
  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
