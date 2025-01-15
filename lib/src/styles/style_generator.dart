import 'dart:io';
import 'package:lumen_ui/src/helpers/package_path_resolver.dart';

class StylesFileReader {
  final PackagePathResolver _packagePathResolver = PackagePathResolver();

  Map<String, String> _findStylesFilePath() {
    final filePath = _packagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lib/src/styles/styles.dart');
    if (File(filePath).existsSync()) {
      final file = File(filePath);
      final content = file.readAsStringSync();

      // Match static TextStyle getters
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

    // Throw an error if no styles file is found
    throw const FileSystemException(
        'Styles file not found. Please ensure the styles file exists.');
  }

  String generateStyleFile(Set<String> usedStyleNames) {
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

  Set<String> extractUsedStyles(String templateContent) {
    final stylesPattern = RegExp(r'AppStyle\.(\w+)');
    final matches = stylesPattern.allMatches(templateContent);
    return matches.map((match) => match.group(1)!).toSet();
  }
}
