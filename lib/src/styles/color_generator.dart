import 'dart:io';
import 'package:lumen_ui/src/generators/package_path_resolver.dart';

class ColorFileReader {
  Map<String, String> _findColorFilePath() {
    final filePath = PackagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lib/src/styles/color.dart');
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

  String generateColorFile(Set<String> usedColorNames) {
    final existingColors = _findColorFilePath();
    final StringBuffer colorFileContent = StringBuffer();
    colorFileContent.writeln("import 'package:flutter/material.dart';");
    colorFileContent.writeln('\nclass AppColors {');
    
    for (final colorName in usedColorNames) {
      if (existingColors.containsKey(colorName)) {
        colorFileContent.writeln('  static const Color $colorName = Color(${existingColors[colorName]});');
      }
    }
    colorFileContent.writeln('}');
    return colorFileContent.toString();
  }

  Set<String> extractUsedColors(String templateContent) {
    // Regular expression to match AppColors.colorName
    final colorPattern = RegExp(r'AppColors\.(\w+)');
    final matches = colorPattern.allMatches(templateContent);
    return matches.map((match) => match.group(1)!).toSet();
  }
}
