import 'dart:io';

import 'package:lumen_ui/src/generator/template_reader.dart';
import 'package:path/path.dart' as path;

class CLIConfig {
  final TemplateReader _templateRegister = TemplateReader();
  
  // Changed to return Future<List<String>>
  Future<List<String>> get supportedTypes => _templateRegister.getTemplateTypes();
  
  // Changed to return Future<List<String>>
  Future<List<String>> get supportedUIs => _templateRegister.getTemplateUIs();
  
  // Changed to return Future<List<String>>
  Future<List<String>> supportedUIsbyType(String type) {
    return _templateRegister.getTemplatebyType(type);
  }

  static const version = '1.0.0';

  static String get defaultOutputPath =>
      path.join(Directory.current.path, 'lib', 'ui');
}