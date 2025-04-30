import 'dart:io';
import 'package:lumen_ui/src/helpers/package_path_resolver.dart';
import 'package:lumen_ui/src/models/template_model.dart';
import 'package:yaml/yaml.dart';

class TemplateReader {
  List<TemplateModel>? _templates;
  final PackagePathResolver _packagePathResolver = PackagePathResolver();
  Future<void>? _initializationFuture;

  TemplateReader() {
    // Start initialization immediately but don't wait for it
    _initializationFuture = _initializeTemplates();
  }

  // Method to ensure templates are loaded
  Future<void> ensureInitialized() async {
    if (_templates == null) {
      await _initializationFuture;
    }
  }

  // Initialize templates asynchronously
  Future<void> _initializeTemplates() async {
    _templates = await _loadTemplates();
  }

  // Method to get templates safely
  List<TemplateModel> get templates {
    if (_templates == null) {
      throw StateError('Templates not initialized. Call ensureInitialized() first.');
    }
    return _templates!;
  }

  // Changed to return Future<List<TemplateModel>>
  Future<List<TemplateModel>> _loadTemplates() async {
    // Use await to get the actual String value
    final filePath = await _packagePathResolver.resolvePackageTemplatePath(
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

  // Make all methods that use templates async
  Future<List<String>> getTemplateTypes() async {
    await ensureInitialized();
    return templates.map((t) => t.type).toSet().toList();
  }

  Future<List<String>> getTemplateUIs() async {
    await ensureInitialized();
    return templates.map((t) => t.name).toSet().toList();
  }

  Future<List<String>> getTemplatebyType(String type) async {
    await ensureInitialized();
    List<String> templateNames = [];
    for (final template in templates) {
      if (template.type == type) {
        templateNames.add(template.name);
      }
    }
    return templateNames;
  }

  Future<TemplateModel> getTemplate(String type, String name) async {
    await ensureInitialized();
    return templates.firstWhere((t) => t.type == type && t.name == name);
  }
}