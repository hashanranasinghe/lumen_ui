import 'dart:io';

import 'package:lumen_ui/src/widgets/template_register.dart';
import 'package:path/path.dart' as path;
class CLIConfig {
  final TemplateRegister _templateRegister = TemplateRegister();
  List<String> get supportedTypes => _templateRegister.getTemplateTypes();
  List<String> get supportedUIs => _templateRegister.getTemplateUIs();
  static const version = '1.0.0';
  
  static String get defaultOutputPath => path.join(Directory.current.path, 'lib', 'ui');
}