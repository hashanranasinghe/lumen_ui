import 'package:lumen_ui/src/helpers/package_path_resolver.dart';
import 'package:lumen_ui/src/helpers/project_path_detector.dart';
import 'package:lumen_ui/src/helpers/shared_helper.dart';
import 'package:lumen_ui/src/models/template_model.dart';
import 'package:lumen_ui/src/styles/color/color_generator.dart';
import 'package:lumen_ui/src/styles/style/style_generator.dart';

import 'package:lumen_ui/src/generator/template_reader.dart';
import 'package:path/path.dart' as path;

class BaseGenerator {
  final ProjectPathDetector _projectPathDetector = ProjectPathDetector();
  final ColorFileReader _colorFileReader = ColorFileReader();
  final StylesFileReader _stylesFileReader = StylesFileReader();
  final PackagePathResolver _packagePathResolver = PackagePathResolver();
  final SharedHelpers _sharedHelpers = SharedHelpers();
  final TemplateReader _templateRegister = TemplateReader();

  Future<void> generate({
    required String name,
    required String outputDirectory,
    required String type,
    required String ui,
    bool verbose = false,
  }) async {
    if (!_sharedHelpers.isValidComponentName(name)) {
      throw ArgumentError('Invalid button name: $name');
    }
    final templateUI = _templateRegister.getTemplate(type, ui);

    final fileName = '${name}_$type.dart';
    final filePath = path.join(outputDirectory, templateUI.folder, fileName);
    final colorFilePath = path.join(outputDirectory, 'styles', 'color.dart');
    final styleFilePath = path.join(outputDirectory, 'styles', 'styles.dart');

    // Ensure both the buttons and styles directories exist
    await _sharedHelpers.ensureDirectoryExists(path.dirname(filePath));
    await _sharedHelpers.ensureDirectoryExists(path.dirname(colorFilePath));

    final newTemplate = _readTemplate(
        template: templateUI,
        colorFilePath: colorFilePath,
        styleFilePath: styleFilePath);

    final newStyleFile = await _stylesFileReader.createStyleFile(
        path: styleFilePath, temp: newTemplate);

    final temp = newTemplate + newStyleFile;

    final newColorFile =
        await _colorFileReader.createColorFile(path: colorFilePath, temp: temp);

    await _sharedHelpers.createFile(path: colorFilePath, content: newColorFile);
    await _sharedHelpers.createFile(path: styleFilePath, content: newStyleFile);
    await _sharedHelpers.createFile(path: filePath, content: newTemplate);
  }

  String _readTemplate(
      {required TemplateModel template,
      required String colorFilePath,
      required String styleFilePath}) {
    final templatePath = _packagePathResolver.resolvePackageTemplatePath(
        'lumen_ui', template.path);

    String newTemplate = _sharedHelpers.readTemplateFile(templatePath);

    newTemplate = newTemplate.replaceAll(
        'Template', _sharedHelpers.capitalize(template.name));
    newTemplate = newTemplate.replaceAll(
      'package:lumen_ui/src/styles/color/color.dart',
      _sharedHelpers.extractLastLibPath(
          colorFilePath, _projectPathDetector.detectProjectName()),
    );
    newTemplate = newTemplate.replaceAll(
      'package:lumen_ui/src/styles/style/styles.dart',
      _sharedHelpers.extractLastLibPath(
          styleFilePath, _projectPathDetector.detectProjectName()),
    );
    return newTemplate;
  }
}
