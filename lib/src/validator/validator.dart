import 'dart:io';
import 'package:path/path.dart' as path;

class StructureValidator {
  final Directory widgetsRoot;
  final _violations = <String>[];

  StructureValidator(String projectRoot)
      : widgetsRoot =
            Directory(path.join(projectRoot, 'lib', 'src', 'widgets'));

  List<String> validateStructure() {
    if (!widgetsRoot.existsSync()) {
      return ['Missing widgets directory at ${widgetsRoot.path}'];
    }

    _validateCategories();
    return _violations;
  }

  void _validateCategories() {
    final entries = widgetsRoot.listSync();

    if (entries.isEmpty) {
      _violations.add('Widgets directory is empty');
      return;
    }

    for (final entry in entries) {
      if (entry is File) {
        _violations.add(
            'Violation: Found a file instead of a category folder - ${path.basename(entry.path)}');
        continue;
      }

      if (entry is Directory) {
        final categoryName = path.basename(entry.path);

        if (!_isValidName(categoryName)) {
          _violations.add('Invalid category name: $categoryName');
          continue;
        }
        if (!_isPlural(categoryName)) {
          _violations.add(
              'Violation: Component name should be plural - $categoryName');
        }

        _validateComponents(entry);
      }
    }
  }

  void _validateComponents(Directory categoryDir) {
    final entries = categoryDir.listSync();

    if (entries.isEmpty) {
      _violations.add('Empty category directory: ${categoryDir.path}');
      return;
    }

    for (final entry in entries) {
      if (entry is File) {
        _violations.add(
          'Violation: Found a file instead of folders in "${path.basename(categoryDir.path)}" - ${path.basename(entry.path)}',
        );
        continue;
      }

      if (entry is Directory) {
        final componentName = path.basename(entry.path);
        if (!_isValidName(componentName)) {
          _violations.add('Invalid component name: $componentName');
        }

        _validateTemplate(entry);
      }
    }
  }

  void _validateTemplate(Directory componentDir) {
    final files = componentDir.listSync().whereType<File>();
    final templateFile = files.firstWhere(
      (f) => path.basename(f.path) == 'template.dart',
      orElse: () => File(''),
    );

    if (!templateFile.existsSync()) {
      _violations.add(
          'Missing template.dart in ${componentDir.path} or rename it to template.dart');
    } else if (files.length > 1) {
      _violations.add('Extra files found in ${componentDir.path}');
    }

    if (templateFile.existsSync()) {
      _validateTemplateContent(templateFile);
    }
  }

  void _validateTemplateContent(File templateFile) {
    final content = templateFile.readAsStringSync();
    if (!content.contains(RegExp(r'class Template\b'))) {
      _violations.add('Missing Template class in ${templateFile.path}');
    }

    if (content.contains(RegExp(r'class Template\w+\b'))) {
      _violations.add(
          'Template class must be named exactly "Template" in ${templateFile.path}');
    }
  }

  bool _isValidName(String name) {
    return RegExp(r'^[a-z_]+$').hasMatch(name) &&
        !name.contains('__') &&
        !name.startsWith('_') &&
        !name.endsWith('_');
  }
}

bool _isPlural(String name) {
  return name.endsWith('s');
}
