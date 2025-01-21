import 'dart:io';

import 'package:lumen_ui/src/helpers/package_path_resolver.dart';
import 'package:lumen_ui/src/helpers/project_path_detector.dart';
import 'package:lumen_ui/src/helpers/shared_helper.dart';
import 'package:lumen_ui/src/styles/color_generator.dart';
import 'package:lumen_ui/src/styles/style_generator.dart';
import 'package:lumen_ui/src/widgets/template_register.dart';
import 'package:path/path.dart' as path;

class BaseGenerator {
  final ProjectPathDetector _projectPathDetector = ProjectPathDetector();
  final ColorFileReader _colorFileReader = ColorFileReader();
  final StylesFileReader _stylesFileReader = StylesFileReader();
  final PackagePathResolver _packagePathResolver = PackagePathResolver();
  final SharedHelpers _sharedHelpers = SharedHelpers();
  final TemplateRegister _templateRegister = TemplateRegister();

  Future<void> generate({
    required String name,
    required String outputDirectory,
    required String type,
  }) async {
    if (!_sharedHelpers.isValidComponentName(name)) {
      throw ArgumentError('Invalid button name: $name');
    }
    final tempPath = _templateRegister.getTemplatePath(type);
    final tempFolder = _templateRegister.getTemplateFolder(type);
    if (tempPath == null || tempFolder == null) {
      throw ArgumentError('Invalid template type: $type');
    }
    final fileName = '${name.toLowerCase()}_$type.dart';
    final filePath = path.join(outputDirectory, tempFolder, fileName);
    final colorFilePath = path.join(outputDirectory, 'styles', 'color.dart');
    final styleFilePath = path.join(outputDirectory, 'styles', 'styles.dart');

    // Ensure both the buttons and styles directories exist
    await _sharedHelpers.ensureDirectoryExists(path.dirname(filePath));
    await _sharedHelpers.ensureDirectoryExists(path.dirname(colorFilePath));
    final template =
        _readTemplate(name, colorFilePath, styleFilePath, type, tempPath);
    final usedStyles = _stylesFileReader.extractUsedStyles(template);
    final styleFile = _stylesFileReader.generateStyleFile(usedStyles);
    final temp = template + styleFile;
    final usedColors = _colorFileReader.extractUsedColors(temp);
    final colorFile = _colorFileReader.generateColorFile(usedColors);

    await _sharedHelpers.createFile(path: colorFilePath, content: colorFile);
    await _sharedHelpers.createFile(path: styleFilePath, content: styleFile);
    await _sharedHelpers.createFile(path: filePath, content: template);
  }

  String _readTemplate(String name, String colorFilePath, String styleFilePath,
      String type, String tempPath) {
    final templatePath =
        _packagePathResolver.resolvePackageTemplatePath('lumen_ui', tempPath);

    String template = _sharedHelpers.readTemplateFile(templatePath);

    template = template.replaceAll('${_sharedHelpers.capitalize(type)}Template',
        '${_sharedHelpers.capitalize(name)}${_sharedHelpers.capitalize(type)}');
    template = template.replaceAll(
      'package:lumen_ui/src/styles/color.dart',
      _sharedHelpers.extractLastLibPath(
          colorFilePath, _projectPathDetector.detectProjectName()),
    );
    template = template.replaceAll(
      'package:lumen_ui/src/styles/styles.dart',
      _sharedHelpers.extractLastLibPath(
          styleFilePath, _projectPathDetector.detectProjectName()),
    );
    return template;
  }

  bool isValidComponentName(String name) {
    // Basic validation: alphanumeric and not empty
    return name.isNotEmpty && RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$').hasMatch(name);
  }

  // Enhanced file creation utility that handles updates
  Future<void> createFile({
    required String path,
    required String content,
  }) async {
    final file = File(path);

    try {
      if (await file.exists() && path.endsWith('color.dart')) {
        // Handle color file updates
        final existingContent = await file.readAsString();
        final mergedContent = _mergeColorFiles(existingContent, content);
        await file.writeAsString(mergedContent);
      } else {
        // Create new file or overwrite existing non-color files
        await file.create(recursive: true);
        await file.writeAsString(content);
      }
    } catch (e) {
      throw Exception('Failed to update or create file at $path: $e');
    }
  }

  // Helper method to merge color files
  String _mergeColorFiles(String existingContent, String newContent) {
    final existingColors = _extractColorDefinitions(existingContent);
    final newColors = _extractColorDefinitions(newContent);

    // Merge colors, keeping all existing colors and adding new ones
    final mergedColors = {...existingColors, ...newColors};

    // Generate merged content
    final buffer = StringBuffer();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln('\nclass AppColors {');

    // Sort color names for consistency
    final sortedColorNames = mergedColors.keys.toList()..sort();
    for (final colorName in sortedColorNames) {
      buffer.writeln('  ${mergedColors[colorName]}');
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  // Helper method to extract color definitions
  Map<String, String> _extractColorDefinitions(String content) {
    final Map<String, String> colors = {};
    final colorPattern =
        RegExp(r'static const Color (\w+)\s*=\s*Color\((0x[A-Fa-f0-9]+)\);');

    for (final match in colorPattern.allMatches(content)) {
      final colorName = match.group(1)!;
      final fullDefinition =
          'static const Color $colorName = Color(${match.group(2)});';
      colors[colorName] = fullDefinition;
    }

    return colors;
  }
}
