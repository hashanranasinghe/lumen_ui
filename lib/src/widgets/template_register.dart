import 'dart:io';
import 'package:lumen_ui/src/models/template_model.dart';
import 'package:yaml/yaml.dart';

class TemplateRegister {
  late List<TemplateModel> templates;

  TemplateRegister() {
    templates = _loadTemplates();
  }

  List<TemplateModel> _loadTemplates() {
    const configPath = '../lumen_ui_config.yaml';
    final file = File(configPath);
    final List<TemplateModel> loadedTemplates = [];

    if (!file.existsSync()) {
      throw Exception('Config file not found at $configPath');
    }

    final yamlString = file.readAsStringSync();
    final yamlMap = loadYaml(yamlString) as Map;

    (yamlMap['templates'] as Map).forEach((categoryKey, categoryValue) {
      final categoryType = categoryKey.toString();
      final categoryTemplates = categoryValue as Map;

      categoryTemplates.forEach((templateName, templateValue) {
        final templateMap = (templateValue as Map).cast<String, dynamic>();
        // Create a combined map with all required fields
        final combinedMap = {
          'name': templateName.toString(),
          'type': categoryType,
          ...templateMap.map((k, v) => MapEntry(k, v.toString())),
        };

        loadedTemplates.add(TemplateModel.fromMap(combinedMap));
      });
    });

    return loadedTemplates;
  }

  List<String> getTemplateTypes() {
    return templates.map((t) => t.type).toSet().toList();
  }

  List<String> getTemplateUIs() {
    return templates.map((t) => t.name).toSet().toList();
  }

  TemplateModel getTemplate(String type, String name) {
    return templates.firstWhere((t) => t.type == type && t.name == name);
  }
}
