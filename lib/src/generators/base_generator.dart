import 'package:lumen_ui/src/helpers/package_path_resolver.dart';
import 'package:lumen_ui/src/helpers/project_path_detector.dart';
import 'package:lumen_ui/src/helpers/shared_helper.dart';
import 'package:lumen_ui/src/styles/color/color_generator.dart';
import 'package:lumen_ui/src/styles/style/style_generator.dart';

import 'package:lumen_ui/src/widgets/template_register.dart';
import 'package:path/path.dart' as path;

class BaseGenerator {
  final ProjectPathDetector _projectPathDetector = ProjectPathDetector();
  final ColorFileReader _colorFileReader = ColorFileReader();
  final StylesFileReader _stylesFileReader = StylesFileReader();
  final PackagePathResolver _packagePathResolver = PackagePathResolver();
  final SharedHelpers _sharedHelpers = SharedHelpers();
  final TemplateRegister _templateRegister = TemplateRegister();

  Future<void> generate({
    required String name,
    required String outputDirectory,
    required String type,
    bool verbose = false,
  }) async {
    if (!_sharedHelpers.isValidComponentName(name)) {
      throw ArgumentError('Invalid button name: $name');
    }
    final tempPath = _templateRegister.getTemplatePath(type);
    final tempFolder = _templateRegister.getTemplateFolder(type);
    if (tempPath == null || tempFolder == null) {
      throw ArgumentError('Invalid template type: $type');
    }
    final fileName = '${name.toLowerCase()}_$type.dart';
    final filePath = path.join(outputDirectory, tempFolder, fileName);
    final colorFilePath = path.join(outputDirectory, 'styles', 'color.dart');
    final styleFilePath = path.join(outputDirectory, 'styles', 'styles.dart');

    // Ensure both the buttons and styles directories exist
    await _sharedHelpers.ensureDirectoryExists(path.dirname(filePath));
    await _sharedHelpers.ensureDirectoryExists(path.dirname(colorFilePath));

    final template =
        _readTemplate(name, colorFilePath, styleFilePath, type, tempPath);

    final newStyleFile = await _stylesFileReader.createStyleFile(
        path: styleFilePath, temp: template);

    final temp = template + newStyleFile;

    final newColorFile =
        await _colorFileReader.createColorFile(path: colorFilePath, temp: temp);

    await _sharedHelpers.createFile(path: colorFilePath, content: newColorFile);
    await _sharedHelpers.createFile(path: styleFilePath, content: newStyleFile);
    await _sharedHelpers.createFile(path: filePath, content: template);
  }

  String _readTemplate(String name, String colorFilePath, String styleFilePath,
      String type, String tempPath) {
    final templatePath =
        _packagePathResolver.resolvePackageTemplatePath('lumen_ui', tempPath);

    String template = _sharedHelpers.readTemplateFile(templatePath);

    template = template.replaceAll('${_sharedHelpers.capitalize(type)}Template',
        '${_sharedHelpers.capitalize(name)}${_sharedHelpers.capitalize(type)}');
    template = template.replaceAll(
      'package:lumen_ui/src/styles/color.dart',
      _sharedHelpers.extractLastLibPath(
          colorFilePath, _projectPathDetector.detectProjectName()),
    );
    template = template.replaceAll(
      'package:lumen_ui/src/styles/styles.dart',
      _sharedHelpers.extractLastLibPath(
          styleFilePath, _projectPathDetector.detectProjectName()),
    );
    return template;
  }
}
