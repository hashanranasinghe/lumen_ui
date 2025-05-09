import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';

/// A password input field with visibility toggle and integrated validation.
///
/// Features:
/// - Obscured text with toggleable visibility
/// - Themed styling with adaptive borders and padding
/// - Built-in error validation and change handling
///
/// ### Parameters:
/// - [controller] (required): Controls the password text.
/// - [onChanged] (required): Triggered on input change.
/// - [validator] (required): Returns error text if validation fails.
/// - [label]: Field label text. Default is `"Password"`.
/// - [icon]: Prefix icon. Default is `Icons.lock_outline`.
/// - [textInput]: Keyboard type. Default is `TextInputType.text`.
class Passwordtextinputfield extends StatefulWidget {
  final String label;
  final IconData icon;
  final double fontSize;
  final TextInputType textInput;
  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const Passwordtextinputfield({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.validator,
    this.label = "Password",
    this.icon = Icons.lock_outline,
    this.textInput = TextInputType.text,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  State<Passwordtextinputfield> createState() => _PasswordtextinputfieldState();
}

class _PasswordtextinputfieldState extends State<Passwordtextinputfield> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validator,
        obscureText: _isPasswordHidden,
        obscuringCharacter: '•',
        keyboardType: widget.textInput,
        style: TextStyle(
          fontSize: widget.fontSize,
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
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: widget.fontSize,
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

/// ### Example Usage:
/// ```dart
/// Passwordtextinputfield(
///   controller: TextEditingController(),
///   onChanged: (value) => print(value),
///   validator: (value) => value?.length < 8 ? 'Minimum 8 characters' : null,
///   label: 'Password',
///   icon: Icons.lock_outline,
/// )
/// ```
