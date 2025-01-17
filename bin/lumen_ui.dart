import 'dart:io';

import 'package:args/args.dart';
import 'package:lumen_ui/lumen_ui.dart';

void main(List<String> arguments) {
  // Detect default output path
    Directory currentDir = Directory.current;

  final parser = ArgParser()
    ..addOption('type',
        abbr: 't',
        help: 'Type of component to generate (button, textfield, etc.)')
    ..addOption('name', abbr: 'n', help: 'Name of the component')
    ..addOption('output',
        abbr: 'o', help: 'Output directory', defaultsTo: '${currentDir.path}\\lib\\ui')
    ..addFlag('help',
        abbr: 'h', negatable: false, help: 'Show usage information');

  try {
    final results = parser.parse(arguments);

    // Show help
    if (results['help']) {
      _printUsage(parser);
      return;
    }

    // Validate required arguments
    if (results['type'] == null || results['name'] == null) {
      print('Error: Both --type and --name are required.');
      _printUsage(parser);
      exit(1);
    }

    // Generate component
    LumenUI.generateComponent(
        type: results['type'],
        name: results['name'],
        outputDirectory: results['output']);

    print(
        'Successfully generated ${results['name']} ${results['type']} in ${results['output']}');
  } on ArgParserException catch (e) {
    print('Error: ${e.message}');
    _printUsage(parser);
    exit(1);
  } catch (e) {
    print('Generation failed: $e');
    exit(1);
  }
}

void _printUsage(ArgParser parser) {
  print('Usage: dart run flutter_ui_generator -t <type> -n <name>');
  print('\nOptions:');
  print(parser.usage);
  print('\nExamples:');
  print('  dart run flutter_ui_generator -t button -n primary');
  print('  dart run flutter_ui_generator -t textfield -n outlined');
  print('  dart run flutter_ui_generator -t button -n secondary');
}
