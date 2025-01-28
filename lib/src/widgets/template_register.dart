class TemplateRegister {
  final Map<String, Map<String, String>> templates = {
    'button': {
      'path': 'lib/src/widgets/buttons/button_template.dart',
      'folder': 'buttons'
    },
    'inputfield': {
      'path': 'lib/src/widgets/inputfields/basic_inputfield.dart',
      'folder': 'inputfields'
    },
    'dummy': {
      'path': 'lib/src/widgets/dummy_template.dart',
      'folder': 'dummies'
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
