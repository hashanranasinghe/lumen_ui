import 'dart:io';
import 'package:lumen_ui/src/generators/package_path_resolver.dart';

class ColorFileReader {
  static String findColorFilePath() {
    final filePath = PackagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lib/src/styles/color.dart');
    if (File(filePath).existsSync()) {
      return filePath;
    }

    // Throw an error if no color file is found
    throw const FileSystemException(
        'Color file not found. Please ensure the color file exists.');
  }

  static String readColorFile() {
    try {
      // Find and read the color file
      final colorFilePath = findColorFilePath();
      return File(colorFilePath).readAsStringSync();
    } catch (e) {
      // Fallback to a default color implementation if file can't be read
      return ('Warning: Could not read color file. Using default color implementation.');
    }
  }
}
