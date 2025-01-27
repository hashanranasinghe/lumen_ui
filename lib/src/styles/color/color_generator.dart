import 'dart:io';

import 'package:lumen_ui/src/helpers/package_path_resolver.dart';

class ColorFileReader {
  final PackagePathResolver _packagePathResolver = PackagePathResolver();
  Map<String, String> _findColorFilePath() {
    final filePath = _packagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lib/src/styles/color/color.dart');
    if (File(filePath).existsSync()) {
      final file = File(filePath);
      final content = file.readAsStringSync();
      final colorPattern =
          RegExp(r'static const Color (\w+)\s*=\s*Color\((0x[A-Fa-f0-9]+)\)');
      final matches = colorPattern.allMatches(content);

      final Map<String, String> colors = {};
      for (final match in matches) {
        final colorName = match.group(1)!;
        final colorValue = match.group(2)!;
        colors[colorName] = colorValue;
      }

      return colors;
    }

    // Throw an error if no color file is found
    throw const FileSystemException(
        'Color file not found. Please ensure the color file exists.');
  }

  String _generateColorFile(Set<String> usedColorNames) {
    final existingColors = _findColorFilePath();
    final StringBuffer colorFileContent = StringBuffer();
    colorFileContent.writeln("import 'package:flutter/material.dart';");
    colorFileContent.writeln('\nclass AppColors {');

    for (final colorName in usedColorNames) {
      if (existingColors.containsKey(colorName)) {
        colorFileContent.writeln(
            '  static const Color $colorName = Color(${existingColors[colorName]});');
      }
    }
    colorFileContent.writeln('}');
    return colorFileContent.toString();
  }

  Set<String> _extractUsedColors(String templateContent) {
    // Regular expression to match AppColors.colorName
    final colorPattern = RegExp(r'AppColors\.(\w+)');
    final matches = colorPattern.allMatches(templateContent);
    return matches.map((match) => match.group(1)!).toSet();
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

  Future<String> createColorFile({
    required String path,
    required String temp,
  }) async {
    final file = File(path);

    try {
      final usedColors = _extractUsedColors(temp);
      final oldColorFile = _generateColorFile(usedColors);

      if (await file.exists() && path.endsWith('color.dart')) {
        // Handle color file updates
        final existingContent = await file.readAsString();
        final mergedContent = _mergeColorFiles(existingContent, oldColorFile);
        return mergedContent;
      } else {
        return oldColorFile;
      }
    } catch (e) {
      throw Exception('Failed to update or create file at $path: $e');
    }
  }
}
