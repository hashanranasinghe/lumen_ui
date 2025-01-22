# Lumen UI

A CLI-based Flutter package for generating modular, customizable UI components on demand.

## Motivation

Flutter developers often struggle with bloated UI component libraries that increase app size and affect performance. Lumen UI CLI solves this by providing a command-line tool that generates only the components you need, with full customization options.

## Features

- Modular UI component generation
- Customizable component templates
- Theme and style configuration options
- Material Design and Cupertino guideline compliance
- Inline documentation for generated components

# Installation

Follow these steps to set up your Flutter project and integrate Lumen UI:

## 1. Create a New Flutter Project

### Using Flutter CLI
```bash
 flutter create my_app
 cd my_app
```

### Using VS Code
1. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
2. Type "Flutter: New Project"
3. Select "Application"
4. Choose project directory
5. Name your project

### Using Android Studio
1. Click "New Flutter Project" from welcome screen
2. Select Flutter project type
3. Configure project settings
4. Click "Finish"

> 📚 New to Flutter? Check out the [official Flutter documentation](https://docs.flutter.dev/get-started/install) for detailed setup instructions.

## 2. Add Lumen UI to Your Project

Add this line to your `pubspec.yaml` under dependencies:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  lumen_ui: 0.0.1 # Add Lumen UI package
```

## 3. Install Dependencies

Run this command in your project directory:

```bash
flutter pub get
``` 

## 4. Verify Installation

Run this command to verify the installation:

```bash
flutter pub list
```

You should see `lumen_ui: 0.0.1` in the list of installed packages.

---

🎉 Congratulations! You're now ready to use Lumen UI in your Flutter project.

Continue to the [Usage](#usage) section to learn how to implement Lumen UI components.

## Usage

```bash
dart run lumen_ui [options]
```

### Options

| Option | Alias | Description | Required |
|--------|-------|-------------|----------|
| `--type` | `-t` | Type of component to generate | Yes |
| `--name` | `-n` | Name of the component | Yes |
| `--output` | `-o` | Output directory (defaults to `lib/ui`) | No |
| `--help` | `-h` | Show help information | No |
| `--version` | `-v` | Show version information | No |
| `--verbose` | - | Enable verbose logging | No |

### Component Types

- `button`: Button components
- `dummy`: Dummy components for testing

### Component Naming Rules

- Must start with a letter
- Can contain letters, numbers, and underscores
- Cannot contain spaces or special characters

## Examples

Generate a primary button:
```bash
dart run lumen_ui -t button -n primary
```

Generate with custom output directory:
```bash
dart run lumen_ui -t button -n secondary -o lib/components
```

Enable verbose logging:
```bash
dart run lumen_ui -t dummy -n custom --verbose
```

## Output Structure

Components are generated in the following structure:
```
lib/ui/
  ├── buttons/
  │   └── primary_button.dart
  └── dummies/
      └── custom_dummy.dart
```

## Error Handling

Common error messages and solutions:

- `Both --type and --name are required`: Ensure both `-t` and `-n` options are provided
- `Invalid component name`: Follow the component naming rules
- `Error parsing arguments`: Check the command syntax
- `Invalid argument format`: Verify option values are correct

## Additional Commands

Show help:
```bash
dart run lumen_ui --help
```

Show version:
```bash
dart run lumen_ui --version
```

## Architecture

The project follows a Layered Architecture pattern with:
- HMI Layer: Command-line interface
- Service Layer: Component generation and template services
- Application Layer: Core business logic
- Communication Layer: File system operations

## Technology Stack

- Dart SDK (>=2.18.0)
- Flutter SDK (>=3.0.0)
- Development Tools: VS Code, Android Studio
- CLI Framework: args/cli_util

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Requirements

- Processor: Intel Core i5 or equivalent
- RAM: 8GB minimum (16GB recommended)
- Storage: 500GB SSD
- Operating Systems: Windows, macOS, or Linux

## License

MIT License

## Authors

- [Hashan Ranasinghe](https://github.com/hashanranasinghe)
- [Chathura Janaka ](https://github.com/chathura976)



