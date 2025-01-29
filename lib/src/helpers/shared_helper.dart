import 'dart:io';

class SharedHelpers {
  String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Future<void> createFile(
      {required String path, required String content}) async {
    final file = File(path);
    await file.writeAsString(content);
  }

  bool isValidComponentName(String name) {
    final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$');
    return regex.hasMatch(name);
  }

  String extractLastLibPath(String filePath, String projectName) {
    final regex = RegExp(r'lib[\\/](.*)');
    final match = regex.firstMatch(filePath);

    if (match != null && match.groupCount > 0) {
      return "package:$projectName/${match.group(1)!.replaceAll(r'\', '/')}";
    }
    return "../styles/color.dart";
  }

  Future<void> ensureDirectoryExists(String dirPath) async {
    await Directory(dirPath).create(recursive: true);
  }

  String readTemplateFile(String templatePath) {
    final templateFile = File(templatePath);

    if (!templateFile.existsSync()) {
      throw ArgumentError('Invalid template file: $templatePath');
    }

    try {
      return templateFile.readAsStringSync();
    } catch (e) {
      throw ArgumentError('Error reading template file: $e');
    }
  }
}
