import 'dart:io';
import 'package:lumen_ui/src/generators/package_path_resolver.dart';
import 'package:lumen_ui/src/generators/project_path_detector.dart';
import 'package:lumen_ui/src/styles/color_generator.dart';
import 'package:path/path.dart' as path;
import 'base_generator.dart';

class ButtonGenerator extends BaseGenerator {
  final ProjectPathDetector _projectPathDetector = ProjectPathDetector();
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
    final colorFilePath = path.join(outputDirectory, 'styles', 'color.dart');
    // Ensure buttons directory exists
    await Directory(path.dirname(filePath)).create(recursive: true);

    // Generate button template
    final buttonContent = readButtonTemplate(name, colorFilePath);
    final colorFile = ColorFileReader.readColorFile();
    await createFile(path: colorFilePath, content: colorFile);
    // Create file
    await createFile(path: filePath, content: buttonContent);
  }

  String readButtonTemplate(String name, String colorFilePath) {
    final templatePath = PackagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lib/src/widgets/button_template.dart');

    final templateFile = File(templatePath);

    if (!templateFile.existsSync()) {
      throw ArgumentError('Invalid button: $templateFile');
    }

    try {
      // Read the template file
      String template = templateFile.readAsStringSync();
      final projectName = _projectPathDetector.detectProjectName();
      // Replace placeholders
      template =
          template.replaceAll('ButtonName', '${_capitalize(name)}Button');
      template = template.replaceAll(
        'lumen_ui/src/styles/color.dart',
        '$projectName/ui/styles/color.dart',
      );

      return template;
    } catch (e) {
      throw ArgumentError('Error reading button template: $e');
    }
  }

  // Utility method to capitalize first letter
  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
