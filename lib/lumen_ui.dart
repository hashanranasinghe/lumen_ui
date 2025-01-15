library lumen_ui;

import 'package:lumen_ui/src/generators/button_generator.dart';
export 'src/generators/button_generator.dart';

// Provides a unified interface for component generation
class LumenUI {
  static Future<void> generateComponent({
    required String type,
    required String name,
    required String outputDirectory,
  }) async {
    await ButtonGenerator().generate(
      name: name,
      outputDirectory: outputDirectory,
      type: type.toLowerCase(),
    );
  }
}
