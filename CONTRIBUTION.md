# Lumen UI Component Contribution Guide

## Overview
This guide explains how to add new UI components to the Lumen design system. The system uses:  
- **CLI Tool**: Auto-generates configuration from folder structure  
- **Validation System**: Ensures structural integrity and naming conventions  

## Component Structure Requirements

### 1. Directory Hierarchy
```bash
lib/src/widgets/
├── {category}/          # Component type (e.g., buttons, inputfields)
│   ├── {name}/  # Component implementation (e.g., primary_button)
│   │      └── template.dart # Component template file
```

### 2. Naming Conventions
| Level         | Rules                                                     |
| ------------- | --------------------------------------------------------- |
| **Category**  | - Plural form (e.g., `buttons` not `button`)              |
|               | - Lowercase with underscores                              |
|               | - Must end with `s` (e.g., `dropdowns`)                   |
| **Component** | - Lowercase with underscores (e.g., `primary_text_input`) |
| **Template**  | - Exactly `template.dart`                                 |
|               | - Must contain `class Template`                           |

## Adding New Components: Step-by-Step

### 1. Create Folder Structure
For a new dropdown component:
```bash
mkdir -p lib/src/widgets/dropdowns/primary_custom_dropdown
```

### 2. Add Template File
Create `template.dart` with:
```dart
// lib/src/widgets/dropdowns/primary_custom_dropdown/template.dart
class Template {
  // Your component implementation
}
```

### 3. Update Configuration
Run the CLI tool:
```bash
dart run bin/update_lumen_config.dart
```

This generates:
```yaml
# lumen_ui_config.yaml
templates:
  dropdown:
    primarycustomdropdown:
      path: "lib/src/widgets/dropdowns/primary_custom_dropdown/template.dart"
      folder: "dropdowns/primary_custom_dropdown"
      suffix_file: "_customdropdown"
      suffix_name: "Customdropdown"
```

## Validation System Explained

### What We Check
1. **Structural Integrity**
```dart
// Valid directory structure check
void _validateCategories() {
  final entries = widgetsRoot.listSync();
  // Rejects files in category directory
}
```

2. **Naming Conventions**
```dart
bool _isValidName(String name) {
  return RegExp(r'^[a-z_]+$').hasMatch(name) 
    && !name.contains('__')
    && !name.startsWith('_')
    && !name.endsWith('_');
}
```

3. **Template Requirements**
```dart
void _validateTemplateContent(File templateFile) {
  // Ensures exact "Template" class exists
  if (!content.contains(RegExp(r'class Template\b'))) {
    _violations.add('Missing Template class');
  }
}
```

### Common Validation Errors
| Error Message                          | Solution                           |
| -------------------------------------- | ---------------------------------- |
| `Found file in category directory`     | Remove files from category folders |
| `Invalid category name: Buttons`       | Use lowercase (buttons)            |
| `Missing template.dart`                | Add template file                  |
| `Extra files found`                    | Remove non-template files          |
| `Template class must be named exactly` | Rename class to `Template`         |

## Best Practices

1. **Testing Setup**
```bash
# Dry-run validation
dart run bin/update_lumen_config.dart
```

2. **Consistent Updates**
```bash
# Always run after structural changes
dart run bin/update_lumen_config.dart
```

3. **Template Hygiene**
- Keep template.dart focused on core functionality
- Avoid helper files in component directories
- Use proper suffix patterns:
  ```dart
  // Auto-generated suffixes
  final suffixFile = '_${baseName}';
  final suffixName = '${PascalCase}';
  ```

## Troubleshooting

### Common Issues
1. **Validation False Positives**
   - Check folder naming (must be plural)
   - Verify template.dart exists with exact name

2. **CLI Generation Failures**
   - Ensure primary_ prefix in component folders
   - Confirm lib/src/widgets exists

3. **YAML Format Issues**
   - Never edit lumen_ui_config.yaml manually
   - Regenerate after structural changes

This documentation ensures consistent component implementation while leveraging the automated tooling. Always validate your changes before submitting pull requests.