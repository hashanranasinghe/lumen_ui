import 'dart:io';

abstract class BaseGenerator {
  // Abstract method to be implemented by specific generators
  Future<void> generate({
    required String name,
    required String outputDirectory,
    required String type,
  });

  // Utility method to validate component name
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
    final colorPattern = RegExp(r'static const Color (\w+)\s*=\s*Color\((0x[A-Fa-f0-9]+)\);');
    
    for (final match in colorPattern.allMatches(content)) {
      final colorName = match.group(1)!;
      final fullDefinition = 'static const Color $colorName = Color(${match.group(2)});';
      colors[colorName] = fullDefinition;
    }
    
    return colors;
  }
}