import 'dart:io';
import 'package:lumen_ui/src/generators/package_path_resolver.dart';
import 'package:lumen_ui/src/styles/color_generator.dart';
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
    final filePath = path.join(outputDirectory,'buttons', fileName);
    final colorFilePath = path.join(outputDirectory,'styles', 'color.dart');
    // Ensure buttons directory exists
    await Directory(path.dirname(filePath)).create(recursive: true);

    // Generate button template
    final buttonContent = readButtonTemplate(name);
    final colorFile = ColorFileReader.readColorFile();
    await createFile(path: colorFilePath, content: colorFile);
    // Create file
    await createFile(path: filePath, content: buttonContent);
  }

  String readButtonTemplate(String name) {
    // Possible template paths
    final templatePath = PackagePathResolver.resolvePackageTemplatePath(
      'lumen_ui', 
      'lib/src/widgets/button_template.dart'
    );

    // Try to find and read the template file
    final templateFile = File(templatePath);

    if (templateFile.existsSync()) {
      try {
        // Read the template file
        String template = templateFile.readAsStringSync();

        // Replace placeholders
        template =
            template.replaceAll('ButtonName', '${_capitalize(name)}Button');

        return template;
      } catch (e) {
        throw ArgumentError('Invalid button:$templateFile');
      }
    }
        throw ArgumentError('Invalid button:$templateFile');

  }

  // Utility method to capitalize first letter
  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
