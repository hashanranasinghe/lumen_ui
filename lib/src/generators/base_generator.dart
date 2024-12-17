import 'dart:io';

abstract class BaseGenerator {
  // Abstract method to be implemented by specific generators
  Future<void> generate({
    required String name,
    required String outputDirectory,
  });

  // Utility method to validate component name
  bool isValidComponentName(String name) {
    // Basic validation: alphanumeric and not empty
    return name.isNotEmpty && 
           RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$').hasMatch(name);
  }

  // Common file creation utility
  Future<void> createFile({
    required String path, 
    required String content
  }) async {
    final file = File(path);
    await file.create(recursive: true);
    await file.writeAsString(content);
  }
}
