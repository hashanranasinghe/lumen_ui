library lumen_ui;

import 'package:lumen_ui/src/generator/base_generator.dart';


// Provides a unified interface for component generation
class LumenUI {
  Future<void> generateComponent({
    required String type,
    required String name,
    required String ui,
    required String outputDirectory,
    bool verbose = false,
  }) async {
    await BaseGenerator().generate(
      name: name,
      ui:ui.toLowerCase(),
      outputDirectory: outputDirectory,
      type: type.toLowerCase(),
      verbose: verbose,
    );
  }
}
