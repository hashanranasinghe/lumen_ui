import 'dart:io';
import 'package:lumen_ui/src/helpers/package_path_resolver.dart';

class StylesFileReader {
  final PackagePathResolver _packagePathResolver = PackagePathResolver();

  Map<String, String> _findStylesFilePath() {
    final filePath = _packagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lib/src/styles/style/styles.dart');
    if (File(filePath).existsSync()) {
      final file = File(filePath);
      final content = file.readAsStringSync();
      final textStylePattern =
          RegExp(r'static TextStyle get (\w+) => const TextStyle\(([^;]+)\);');
      final textStyleMatches = textStylePattern.allMatches(content);
      final Map<String, String> textStyles = {};
      for (final match in textStyleMatches) {
        final styleName = match.group(1)!;
        final styleDefinition = match.group(2)!.trim();
        textStyles[styleName] = styleDefinition;
      }
      return textStyles;
    }
    throw const FileSystemException(
        'Styles file not found. Please ensure the styles file exists.');
  }

  // Helper method to extract style definitions
  Map<String, String> _extractStyleDefinitions(String content) {
    final Map<String, String> styles = {};
    final stylePattern =
        RegExp(r'static TextStyle get (\w+) => const TextStyle\(([^;]+)\);');
    for (final match in stylePattern.allMatches(content)) {
      final styleName = match.group(1)!;
      final fullDefinition =
          'static TextStyle get $styleName => const TextStyle(${match.group(2)});';
      styles[styleName] = fullDefinition;
    }
    return styles;
  }

  // Helper method to merge style files
  String _mergeStyleFiles(String existingContent, String newContent) {
    final existingStyles = _extractStyleDefinitions(existingContent);
    final newStyles = _extractStyleDefinitions(newContent);
    // Merge styles, keeping all existing styles and adding new ones
    final mergedStyles = {...existingStyles, ...newStyles};

    // Generate merged content
    final buffer = StringBuffer();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'color.dart';");
    buffer.writeln('\nclass AppStyle {');

    // Sort style names for consistency
    final sortedStyleNames = mergedStyles.keys.toList()..sort();
    for (final styleName in sortedStyleNames) {
      buffer.writeln('  ${mergedStyles[styleName]}');
    }
    buffer.writeln('}');
    return buffer.toString();
  }

  String _generateStyleFile(Set<String> usedStyleNames) {
    final existingStyles = _findStylesFilePath();
    final StringBuffer styleFileContent = StringBuffer();
    styleFileContent.writeln("import 'package:flutter/material.dart';");
    styleFileContent.writeln("import 'color.dart';");
    styleFileContent.writeln('\nclass AppStyle {');
    for (final styleName in usedStyleNames) {
      if (existingStyles.containsKey(styleName)) {
        final styleValue = existingStyles[styleName]!;
        styleFileContent.writeln(
            '  static TextStyle get $styleName => const TextStyle($styleValue);');
      }
    }
    styleFileContent.writeln('}');
    return styleFileContent.toString();
  }

  Set<String> _extractUsedStyles(String templateContent) {
    final stylesPattern = RegExp(r'AppStyle\.(\w+)');
    final matches = stylesPattern.allMatches(templateContent);
    return matches.map((match) => match.group(1)!).toSet();
  }

  Future<String> createStyleFile({
    required String path,
    required String temp,
  }) async {
    final file = File(path);
    try {
      final usedStyles = _extractUsedStyles(temp);
      final oldStyleFile = _generateStyleFile(usedStyles);
      if (await file.exists() && path.endsWith('styles.dart')) {
        // Handle style file updates
        final existingContent = await file.readAsString();
        final mergedContent = _mergeStyleFiles(existingContent, oldStyleFile);
        return mergedContent;
      } else {
        return oldStyleFile;
      }
    } catch (e) {
      throw Exception('Failed to update or create file at $path: $e');
    }
  }
}