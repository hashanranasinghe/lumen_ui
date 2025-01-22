class TemplateRegister {
  final Map<String, Map<String, String>> templates = {
    'button': {
      'path': 'lib/src/widgets/button_template.dart',
      'folder': 'buttons'
    },
    // Add other templates here
  };

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
