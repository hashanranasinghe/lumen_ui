// test/cli_test.dart
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:lumen_ui/lumen_ui.dart';
import 'package:lumen_ui/src/config/cli.dart';
import 'package:lumen_ui/src/config/cli_config.dart';
import 'package:lumen_ui/src/models/error_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:process_run/process_run.dart';
import 'package:test/test.dart';

@GenerateMocks([LumenUI])
import 'lumen_ui_test.mocks.dart';

void main() {
  // Get the project root path
   final projectRoot = Directory.current.path;


  group('CLI Configuration', () {
    setUpAll(() {
      // Copy config file to test directory if needed
      final configFile = File('../lumen_ui_config.yaml');
      if (!configFile.existsSync()) {
        throw Exception('Config file not found in project : $projectRoot');
      }
    });
  });

  group('CLI Argument Parsing', () {
    late CLI cli;
    late MockLumenUI mockLumenUI;

    setUp(() {
      mockLumenUI = MockLumenUI();
      cli = CLI(lumenUI: mockLumenUI);
    });

    test('help flag prints usage', () async {
      final result = await Process.run(
        'dart',
        ['run', path.join(projectRoot, 'bin', 'lumen_ui.dart'), '--help'],
      );
      expect(result.stdout, contains('Lumen UI Component Generator'));
      expect(result.stdout, contains('Usage:'));
      expect(result.exitCode, 0);
    });

    test('version flag prints version', () async {
      final result = await Process.run(
        'dart',
        ['run', path.join(projectRoot, 'bin', 'lumen_ui.dart'), '--version'],
      );
      expect(result.stdout, contains(CLIConfig.version));
      expect(result.exitCode, 0);
    });
  });

  group('Component Generation', () {
    late MockLumenUI mockLumenUI;
    late CLI cli;
    late Directory testDir;

    setUp(() {
      mockLumenUI = MockLumenUI();
      cli = CLI(lumenUI: mockLumenUI);
      testDir = Directory(path.join(projectRoot, 'test', 'temp_output'));
    });

    tearDown(() {
      if (testDir.existsSync()) testDir.deleteSync(recursive: true);
    });

    test('generates component with valid parameters', () async {
      const testArgs = [
        '-t', 'button',
        '-u', 'primarybutton',
        '-n', 'TestButton',
        '-o', 'test/temp_output'
      ];

      when(mockLumenUI.generateComponent(
        type: anyNamed('type'),
        name: anyNamed('name'),
        ui: anyNamed('ui'),
        outputDirectory: anyNamed('outputDirectory'),
        verbose: anyNamed('verbose'),
      )).thenAnswer((_) async => {});

      await cli.run(testArgs);

      verify(mockLumenUI.generateComponent(
        type: 'button',
        name: 'TestButton',
        ui: 'primarybutton',
        outputDirectory: 'test/temp_output',
        verbose: false,
      )).called(1);
    });
  });

  group('Error Handling', () {
    test('handles invalid component type', () async {
      final result = await Process.run(
        'dart',
        [
          'run',
          path.join(projectRoot, 'bin', 'lumen_ui.dart'),
          '-t', 'invalid',
          '-u', 'primary',
          '-n', 'TestButton'
        ],
      );
      print(result.stderr);
      expect(result.stderr, contains('Building'));
      expect(result.exitCode, isNot(0));
    });
  });
}