library lumen_ui;

import 'package:lumen_ui/src/generators/button_generator.dart';
import 'package:lumen_ui/src/generators/textfield_generator.dart';
export 'src/generators/button_generator.dart';
export 'src/generators/textfield_generator.dart';

// Provides a unified interface for component generation
class LumenUI {
  static Future<void> generateComponent({
    required String type,
    required String name,
    String? outputDirectory,
  }) async {
    switch (type.toLowerCase()) {
      case 'button':
        await ButtonGenerator().generate(
          name: name,
          outputDirectory: outputDirectory ?? 'lib/ui',
        );
        break;
      case 'textfield':
        await TextFieldGenerator().generate(
          name: name,
          outputDirectory: outputDirectory ?? 'lib/ui',
        );
        break;
      default:
        throw ArgumentError('Unsupported component type: $type');
    }
  }
}