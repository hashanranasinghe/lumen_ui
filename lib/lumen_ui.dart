library lumen_ui;

import 'package:lumen_ui/src/generators/base_generator.dart';


// Provides a unified interface for component generation
class LumenUI {
  static Future<void> generateComponent({
    required String type,
    required String name,
    required String outputDirectory,
  }) async {
    await BaseGenerator().generate(
      name: name,
      outputDirectory: outputDirectory,
      type: type.toLowerCase(),
    );
  }
}
