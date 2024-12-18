import 'dart:io';
import 'package:path/path.dart' as path;

class ProjectPathDetector {
  static String detectProjectName() {
    // Start from the current working directory
    Directory currentDir = Directory.current;
    
    // Look for pubspec.yaml to confirm it's a Flutter/Dart project
    File pubspecFile = File(path.join(currentDir.path, 'pubspec.yaml'));
    
    if (!pubspecFile.existsSync()) {
      // If no pubspec.yaml in current directory, try parent directories
      currentDir = currentDir.parent;
      pubspecFile = File(path.join(currentDir.path, 'pubspec.yaml'));
    }
    
    if (!pubspecFile.existsSync()) {
      // Fallback to default if no pubspec found
      return 'lib/ui';
    }
    
    // Read pubspec content to extract project name
    try {
      String pubspecContent = pubspecFile.readAsStringSync();
      RegExp nameRegex = RegExp(r'name:\s*([a-zA-Z0-9_]+)');
      Match? match = nameRegex.firstMatch(pubspecContent);
      
      if (match != null) {
        String projectName = match.group(1)!;
        return projectName;
      }
    } catch (e) {
      print('Error reading pubspec.yaml: $e');
    }
    
    // Fallback to default
    return 'lib/ui';
  }

  static String getDefaultOutputDirectory() {
    return path.join(Directory.current.path, detectProjectName());
  }
}