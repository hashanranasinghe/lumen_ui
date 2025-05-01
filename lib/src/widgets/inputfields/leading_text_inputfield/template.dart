import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable text input field with enhanced styling and edit toggle capability.
///
/// Features:
/// - Toggleable edit state with suffix icon (when [hasSuffixIcon] is true)
/// - Integrated validation and error handling
/// - Customizable theme integration
/// - Adaptive content padding and styling
///
/// Usage Example:
/// ```dart
/// Template(
///   controller: TextEditingController(),
///   onChanged: (value) => print(value),
///   validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
///   prefixIcon: Icon(Icons.lock, color: AppColors.md_theme_light_font),
///   hintText: 'Enter password',
///   keyboardType: TextInputType.visiblePassword,
///   hasSuffixIcon: true,
/// )
/// ```
class Template extends StatefulWidget {
  final TextInputType keyboardType;
  final int maxLines;
  final Widget prefixIcon;
  final bool hasSuffixIcon;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  const Template({
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
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
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
        suffixIcon: widget.hasSuffixIcon
            ? _buildEditToggleButton()
            : null,
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