class TemplateRegister {
  final Map<String, String> templates = {
    'button': 'lib/src/widgets/button_template.dart',
    // Add other templates here
  };

  String? getTemplatePath(String type) {
    return templates[type];
  }
}
