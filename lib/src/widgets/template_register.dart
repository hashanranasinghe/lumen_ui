import 'dart:io';

import 'package:yaml/yaml.dart';

class TemplateRegister {
  late Map<String, Map<String, String>> templates;

  TemplateRegister() {
    _loadTemplates();
  }

  void _loadTemplates() {
    const configPath = '../lumen_ui_config.yaml';
    final file = File(configPath);

    if (!file.existsSync()) {
      throw Exception('Config file not found at $configPath');
    }

    final yamlString = file.readAsStringSync();
    final yamlMap = loadYaml(yamlString) as Map;

    templates = (yamlMap['templates'] as Map).map((key, value) {
      return MapEntry(
        key.toString(),
        (value as Map).map((k, v) => MapEntry(k.toString(), v.toString())),
      );
    });
  }

  String? getTemplatePath(String type) {
    return templates[type]?['path'];
  }

  String? getTemplateFolder(String type) {
    return templates[type]?['folder'];
  }

  List<String> getTemplateTypes() {
    return templates.keys.toList();
  }
}
