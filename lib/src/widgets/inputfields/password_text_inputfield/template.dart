import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable password input field with visibility toggle functionality.
///
/// Features:
/// - Secure text entry with obscuring character
/// - Toggleable password visibility
/// - Integrated validation and error handling
/// - Theme-consistent styling
/// - Adaptive content padding and borders
///
/// Usage Example:
/// ```dart
/// Template(
///   controller: TextEditingController(),
///   onChanged: (value) => print(value),
///   validator: (value) => value?.length < 8 ? 'Minimum 8 characters' : null,
///   label: 'Password',
///   icon: Icons.lock_outline,
/// )
/// ```
class Template extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextInputType textInput;
  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const Template({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.validator,
    required this.label,
    this.icon = Icons.lock_outline,
    this.textInput = TextInputType.text,
  }) : super(key: key);

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        obscuringCharacter: '•',
        obscureText: _isPasswordHidden,
        validator: widget.validator,
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: widget.textInput,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.fontPrimary,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.background,
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.outline,
          ),
          label: Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: AppColors.outline,
            ),
          ),
          hintText: 'Enter your password',
          hintStyle: const TextStyle(
            color: AppColors.outline,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildFocusedBorder(),
          suffixIcon: _buildVisibilityToggle(),
        ),
      ),
    );
  }

  Widget _buildVisibilityToggle() {
    return IconButton(
      icon: Icon(
        _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
        color: AppColors.outline,
        size: 22,
      ),
      onPressed: _togglePasswordVisibility,
      splashRadius: 20,
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.outline,
        width: 1.2,
      ),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 1.5,
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() => _isPasswordHidden = !_isPasswordHidden);
  }
}