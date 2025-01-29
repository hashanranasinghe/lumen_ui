import 'dart:io';

import 'package:args/args.dart';
import 'package:lumen_ui/lumen_ui.dart';
import 'package:lumen_ui/src/config/cli_config.dart';
import 'package:lumen_ui/src/models/error_model.dart';

class CLI {
  final ArgParser _parser;

  CLI() : _parser = _createParser();

  static ArgParser _createParser() {
    return ArgParser()
      ..addOption('type',
          abbr: 't',
          help: 'Type of component to generate',
          allowed: CLIConfig().supportedTypes,
          valueHelp: 'component_type')
      ..addOption('ui',
          abbr: 'u',
          help: 'UI type of component to generate',
          allowed: CLIConfig().supportedUIs,
          valueHelp: 'component_UI')
      ..addOption('name',
          abbr: 'n', help: 'Name of the component', valueHelp: 'component_name')
      ..addOption('output',
          abbr: 'o',
          help: 'Output directory for generated components',
          defaultsTo: CLIConfig.defaultOutputPath,
          valueHelp: 'path')
      ..addFlag('help',
          abbr: 'h', negatable: false, help: 'Show this help message')
      ..addFlag('version',
          abbr: 'v', negatable: false, help: 'Show version information')
      ..addFlag('verbose', help: 'Enable verbose logging', defaultsTo: false);
  }

  Future<void> run(List<String> arguments) async {
    try {
      final results = _parser.parse(arguments);
      if (results['help']) {
        _printHelp();
        return;
      }
      if (results['version']) {
        _printVersion();
        return;
      }
      await _validateAndGenerate(results);
    } on ArgParserException catch (e) {
      throw CLIException('Error parsing arguments: ${e.message}',
          helpText: _parser.usage);
    } on FormatException catch (e) {
      throw CLIException('Invalid argument format: ${e.message}',
          helpText: _parser.usage);
    }
  }

  Future<void> _validateAndGenerate(ArgResults results) async {
    // Validate required arguments
    if (results['type'] == null ||
        results['ui'] == null ||
        results['name'] == null) {
      throw CLIException('Both --type and --name and --ui are required.',
          helpText: _parser.usage);
    }

    // Validate component name
    final name = results['name'] as String;
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(name)) {
      throw CLIException(
          'Invalid component name. Must start with a letter and contain only letters, numbers, and underscores.');
    }

    // Validate and create output directory
    final outputDir = Directory(results['output'] as String);
    if (!outputDir.existsSync()) {
      await outputDir.create(recursive: true);
    }

    // Generate the component
    await LumenUI.generateComponent(
      type: results['type'],
      name: results['name'],
      ui: results['ui'],
      outputDirectory: results['output'],
      verbose: results['verbose'],
    );

    print(
        '✓ Successfully generated ${results['name']} ${results['type']} ${results['ui']} in ${results['output']}');
  }

  void _printHelp() {
    print('''
Lumen UI Component Generator v${CLIConfig.version}

Description:
  A command-line tool to generate Flutter UI components with consistent styling and behavior.

Usage:
  dart run lumen_ui [options]

${_parser.usage}

Supported Component Types:
  ${CLIConfig().supportedTypes.join(', ')}

Examples:
  Generate a primary button:
    dart run lumen_ui -t button -u primarybutton -n primary

  Generate an outlined text field in a custom directory:
    dart run lumen_ui -t textfield -u primarytextinputfield -n primary -o lib/components

  Generate a checkbox with verbose logging:
    dart run lumen_ui -t checkbox -u primarycheckbox -n custom --verbose

For more information and documentation, visit:
  https://github.com/hashanranasinghe/lumen_ui.git
''');
  }

  void _printVersion() {
    print('Lumen UI Component Generator v${CLIConfig.version}');
  }
}
