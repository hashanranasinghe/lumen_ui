import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';

/// A styled text input field with optional edit toggle and custom validation.
///
/// Supports both editable and read-only states with a toggle button (if enabled).
/// Built for reusable form fields with integrated styling, validation, and theming.
///
/// ### Parameters:
/// - [controller] (required): Controls the text being edited.
/// - [onChanged] (required): Called when the input value changes.
/// - [validator] (required): Validation function for the input value.
/// - [hintText]: Placeholder text. Default is `"Text"`.
/// - [keyboardType]: Type of keyboard. Default is `TextInputType.text`.
/// - [maxLines]: Number of lines. Default is `1`.
/// - [padding]: Inner padding. Default is `EdgeInsets.all(16)`.
/// - [prefixIcon] (required): Icon displayed at the start of the field.
/// - [hasSuffixIcon]: Whether to show edit/lock toggle icon. Default is `false`.
class Leadingtextinputfield extends StatefulWidget {
  final TextInputType keyboardType;
  final int maxLines;
  final Widget prefixIcon;
  final bool hasSuffixIcon;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  const Leadingtextinputfield({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.validator,
    this.hintText = "Text",
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.padding = const EdgeInsets.all(16),
    required this.prefixIcon,
    this.hasSuffixIcon = false,
  }) : super(key: key);

  @override
  State<Leadingtextinputfield> createState() => _LeadingtextinputfieldState();
}

class _LeadingtextinputfieldState extends State<Leadingtextinputfield> {
  bool _isEditable = false;

  @override
  void initState() {
    _isEditable = !widget.hasSuffixIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return TextFormField(
      enabled: _isEditable,
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.maxLines,
      cursorColor: AppColors.fontPrimary,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.fontPrimary,
      ),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.hasSuffixIcon ? _buildEditToggleButton() : null,
        hintText: widget.hintText,
        contentPadding: widget.padding,
        border: _buildDefaultBorder(),
        enabledBorder: _buildDefaultBorder(),
        focusedBorder: _buildFocusedBorder(),
        filled: true,
        fillColor: AppColors.background,
      ).applyDefaults(themeData.inputDecorationTheme),
    );
  }

  Widget _buildEditToggleButton() {
    return IconButton(
      icon: Icon(
        _isEditable ? Icons.lock_open : Icons.edit,
        color: AppColors.fontPrimary,
        size: 22,
      ),
      onPressed: _toggleEditState,
      splashRadius: 20,
    );
  }

  OutlineInputBorder _buildDefaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.outline,
        width: 1.5,
      ),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 2.0,
      ),
    );
  }

  void _toggleEditState() {
    setState(() => _isEditable = !_isEditable);
  }
}

/// ### Example Usage:
/// ```dart
/// Leadingtextinputfield(
///   controller: TextEditingController(),
///   onChanged: (value) => print(value),
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
///   prefixIcon: Icon(Icons.person, color: AppColors.md_theme_light_font),
///   hintText: 'Enter name',
///   hasSuffixIcon: true,
/// )
/// ```
