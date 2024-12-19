import 'dart:io';
import 'package:lumen_ui/src/generators/package_path_resolver.dart';
import 'package:lumen_ui/src/generators/project_path_detector.dart';
import 'package:lumen_ui/src/styles/color_generator.dart';
import 'package:path/path.dart' as path;
import 'base_generator.dart';

class ButtonGenerator extends BaseGenerator {
  final ProjectPathDetector _projectPathDetector = ProjectPathDetector();
  final ColorFileReader _colorFileReader = ColorFileReader();

  @override
  Future<void> generate({
    required String name,
    required String outputDirectory,
  }) async {
    // Validate component name
    if (!isValidComponentName(name)) {
      throw ArgumentError('Invalid button name: $name');
    }

    // Determine file paths
    final fileName = '${name.toLowerCase()}_button.dart';
    final filePath = path.join(outputDirectory, 'buttons', fileName);
    final colorFilePath = path.join(outputDirectory, 'styles', 'color.dart');
    print(colorFilePath);
    // Ensure buttons directory exists
    await Directory(path.dirname(filePath)).create(recursive: true);

    // Read button template
    final buttonTemplate = readButtonTemplate(name, colorFilePath);

    // Extract colors used in the template
    final usedColors = _colorFileReader.extractUsedColors(buttonTemplate);

    // Parse existing color file and generate new one with only used colors
    final colorFile = _colorFileReader.generateColorFile(usedColors);

    // Create/update the files
    await createFile(path: colorFilePath, content: colorFile);
    await createFile(path: filePath, content: buttonTemplate);
  }

  String readButtonTemplate(String name, String colorFilePath) {
    final templatePath = PackagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lib/src/widgets/button_template.dart');
    final templateFile = File(templatePath);

    if (!templateFile.existsSync()) {
      throw ArgumentError('Invalid button: $templateFile');
    }

    try {
      String template = templateFile.readAsStringSync();
      final projectName = _projectPathDetector.detectProjectName();

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

  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
