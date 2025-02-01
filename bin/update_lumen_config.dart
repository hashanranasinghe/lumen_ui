// bin/update_lumen_config.dart
import 'dart:io';

import 'package:lumen_ui/src/validator/validator.dart';
import 'package:path/path.dart' as path;

void main() {
  final projectRoot = Directory.current;
  final widgetsDir =
      Directory(path.join(projectRoot.path, 'lib', 'src', 'widgets'));
  final violations = StructureValidator(projectRoot.path).validateStructure();
  if (violations.isNotEmpty) {
    throw Exception('Validation failed:\n${violations.join('\n')}');
  }

  final config = <String, dynamic>{'templates': {}};

  // Process widget categories
  widgetsDir.listSync().whereType<Directory>().forEach((categoryDir) {
    final fullCategoryName = path.basename(categoryDir.path);
    final categoryName = fullCategoryName.isNotEmpty
        ? fullCategoryName.substring(0, fullCategoryName.length - 1)
        : fullCategoryName;
    config['templates']![categoryName] = {};

    // Process widget templates
    categoryDir.listSync().whereType<Directory>().forEach((widgetDir) {
      final widgetFolder = path.basename(widgetDir.path);

      if (!widgetFolder.startsWith('primary_')) return;

      final templateFile = File(path.join(widgetDir.path, 'template.dart'));
      if (!templateFile.existsSync()) return;

      final suffixBase = widgetFolder.replaceFirst('primary_', '');
      final suffixFile = '_${suffixBase.replaceAll('_', '')}';
      final suffixName = suffixBase
          .split('_')
          .map((s) => s[0].toUpperCase() + s.substring(1))
          .join();

      final entryKey = widgetFolder.replaceAll('_', '');

      config['templates']![categoryName]![entryKey] = {
        'path': _posixPath(
            path.relative(templateFile.path, from: projectRoot.path)),
        'folder':
            _posixPath(path.relative(widgetDir.path, from: widgetsDir.path)),
        'suffix_file': suffixFile,
        'suffix_name': suffixName,
      };
    });
  });

  _writeYamlConfig(projectRoot, config);
  print('✅ Successfully updated lumen_ui_config.yaml');
}

String _posixPath(String inputPath) => inputPath.replaceAll(r'\', '/');

void _writeYamlConfig(Directory projectRoot, Map<String, dynamic> config) {
  final yamlContent = StringBuffer('# lumen_ui_config.yaml\n'
      '# This file contains the configuration for widget templates.\n'
      '# Each category represents a group of related widgets.\n'
      'templates:\n');

  // Iterate over each category in the templates.
  (config['templates'] as Map).forEach((category, widgets) {
    yamlContent.writeln('  # Category: $category');
    yamlContent.writeln('  $category:');

    // Iterate over each widget in the category.
    (widgets as Map).forEach((widgetKey, data) {
      yamlContent.writeln('    # Widget: $widgetKey');
      yamlContent.writeln('    $widgetKey:');

      // Add each key-value pair for the widget configuration.
      data.forEach((key, value) {
        yamlContent.writeln('      $key: "$value"');
      });

      // Add a blank line for readability between widgets.
      yamlContent.writeln();
    });

    // Add a blank line for readability between categories.
    yamlContent.writeln();
  });

  // Write the YAML content to the file.
  File(path.join(projectRoot.path, 'lumen_ui_config.yaml'))
      .writeAsStringSync(yamlContent.toString());
}
