import 'package:lumen_ui/src/helpers/package_path_resolver.dart';
import 'package:lumen_ui/src/helpers/project_path_detector.dart';
import 'package:lumen_ui/src/helpers/shared_helper.dart';
import 'package:lumen_ui/src/styles/color_generator.dart';
import 'package:lumen_ui/src/widgets/template_register.dart';
import 'package:path/path.dart' as path;
import 'base_generator.dart';

class ButtonGenerator extends BaseGenerator {
  final ProjectPathDetector _projectPathDetector = ProjectPathDetector();
  final ColorFileReader _colorFileReader = ColorFileReader();
  final PackagePathResolver _packagePathResolver = PackagePathResolver();
  final SharedHelpers _sharedHelpers = SharedHelpers();
  final TemplateRegister _templateRegister = TemplateRegister();
  @override
  Future<void> generate({
    required String name,
    required String outputDirectory,
    required String type,
  }) async {
    if (!_sharedHelpers.isValidComponentName(name)) {
      throw ArgumentError('Invalid button name: $name');
    }

    final fileName = '${name.toLowerCase()}_button.dart';
    final filePath = path.join(outputDirectory, 'buttons', fileName);
    final colorFilePath = path.join(outputDirectory, 'styles', 'color.dart');

    // Ensure both the buttons and styles directories exist
    await _sharedHelpers.ensureDirectoryExists(path.dirname(filePath));
    await _sharedHelpers.ensureDirectoryExists(path.dirname(colorFilePath));
    final buttonTemplate = _readButtonTemplate(name, colorFilePath, type);
    final usedColors = _colorFileReader.extractUsedColors(buttonTemplate);
    final colorFile = _colorFileReader.generateColorFile(usedColors);

    await _sharedHelpers.createFile(path: colorFilePath, content: colorFile);
    await _sharedHelpers.createFile(path: filePath, content: buttonTemplate);
  }

  String _readButtonTemplate(String name, String colorFilePath, String type) {
    final path = _templateRegister.getTemplatePath(type);
    if (path == null) {
      throw ArgumentError('Invalid template type: $type');
    }
    final templatePath =
        _packagePathResolver.resolvePackageTemplatePath('lumen_ui', path);

    String template = _sharedHelpers.readTemplateFile(templatePath);

    template = template.replaceAll(
        'ButtonName', '${_sharedHelpers.capitalize(name)}Button');
    template = template.replaceAll(
      'package:lumen_ui/src/styles/color.dart',
      _sharedHelpers.extractLastLibPath(
          colorFilePath, _projectPathDetector.detectProjectName()),
    );

    return template;
  }
}
