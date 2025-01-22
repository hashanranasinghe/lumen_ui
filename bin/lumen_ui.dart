import 'dart:io';

import 'package:lumen_ui/src/config/cli.dart';
import 'package:lumen_ui/src/models/error_model.dart';

void main(List<String> arguments) async {
  try {
    final cli = CLI();
    await cli.run(arguments);
  } on CLIException catch (e) {
    print('Error: ${e.message}');
    if (e.helpText != null) {
      print('\n${e.helpText}');
    }
    exit(e.exitCode);
  } catch (e, stackTrace) {
    print('Unexpected error occurred: $e');
    if (e is FileSystemException) {
      print('File system error: ${e.message}');
    }
    print('Please report this issue on GitHub with the following details:');
    print(stackTrace);
    exit(1);
  }
}
