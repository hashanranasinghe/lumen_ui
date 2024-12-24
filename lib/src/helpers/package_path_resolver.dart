import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

class PackagePathResolver {
  String resolvePackagePath(String packageName) {
    // Find the pubspec.yaml file
    final pubspecFile = File(path.join(Directory.current.path, 'pubspec.yaml'));
    
    if (!pubspecFile.existsSync()) {
      throw const FileSystemException('pubspec.yaml not found');
    }

    // Read the pubspec content
    final pubspecContent = pubspecFile.readAsStringSync();
    final parsedYaml = loadYaml(pubspecContent);

    // Check dev_dependencies
    final devDependencies = parsedYaml['dev_dependencies'] ?? {};
    final packageConfig = devDependencies[packageName];

    if (packageConfig is Map && packageConfig['path'] != null) {
      // Resolve the relative path
      final relativePath = packageConfig['path'];
      final absolutePath = path.normalize(path.join(
        Directory.current.path, 
        relativePath
      ));

      return absolutePath;
    } else if (packageConfig is String) {
      // If it's a direct path string
      final absolutePath = path.normalize(path.join(
        Directory.current.path, 
        packageConfig
      ));

      return absolutePath;
    }

    throw ArgumentError('Package path for $packageName not found in pubspec.yaml');
  }

  String resolvePackageTemplatePath(String packageName, String templateRelativePath) {
    final packagePath = resolvePackagePath(packageName);
    return path.join(packagePath, templateRelativePath);
  }
}