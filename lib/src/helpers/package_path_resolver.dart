import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as path;

class PackagePathResolver {
  Future<String> resolvePackagePath(String packageName) async {
    final packageUri = Uri.parse('package:$packageName/');
    final resolvedUri = await Isolate.resolvePackageUri(packageUri);

    if (resolvedUri == null) {
      throw Exception('Unable to resolve path for package: $packageName');
    }

    // Get the parent directory of the resolved URI
    return File.fromUri(resolvedUri).parent.path;
  }

  Future<String> resolvePackageTemplatePath(String packageName, String templateRelativePath) async {
    final packagePath = await resolvePackagePath(packageName);
    return path.join(packagePath, templateRelativePath);
  }
}
