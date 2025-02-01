import 'dart:io';
import 'package:lumen_ui/src/helpers/package_path_resolver.dart';
import 'package:lumen_ui/src/models/template_model.dart';
import 'package:yaml/yaml.dart';

class TemplateReader {
  late List<TemplateModel> templates;
  final PackagePathResolver _packagePathResolver = PackagePathResolver();

  TemplateReader() {
    templates = _loadTemplates();
  }

  List<TemplateModel> _loadTemplates() {
    final filePath = _packagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', 'lumen_ui_config.yaml');
    final file = File(filePath);
    final List<TemplateModel> loadedTemplates = [];

    if (!file.existsSync()) {
      throw Exception('Config file not found at ${file.path}.');
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

  List<String> getTemplatebyType(String type) {
    List<String> templateNames = [];
    for (final template in templates) {
      if (template.type == type) {
        templateNames.add(template.name);
      }
    }
    return templateNames;
  }

  TemplateModel getTemplate(String type, String name) {
    return templates.firstWhere((t) => t.type == type && t.name == name);
  }
}
