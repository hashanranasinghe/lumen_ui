import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';
import 'package:example/ui/styles/styles.dart';

/// Defines the visual style of the [BasicButton].
enum ButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

/// Defines size presets for the [BasicButton].
enum ButtonSize {
  small,
  medium,
  large,
}

/// A modern, customizable button widget with built-in variants and sizes.
///
/// Easily reusable across an app with support for icons, loading state,
/// splash effects, elevation, and full-width toggling.
///
/// ### Example:
/// ```dart
/// Primarybutton(
///   label: "Submit",
///   variant: ButtonVariant.primary,
///   size: ButtonSize.medium,
///   onPressed: () => print("Button pressed!"),
/// )
/// ```
class BasicButton extends StatelessWidget {
  final String label;
  final ButtonVariant variant;
  final ButtonSize size;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double iconSpacing;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final double? fontSize;
  final Color? splashColor;
  final double elevation;

  const BasicButton({
    Key? key,
    required this.label,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.onPressed,
    this.isFullWidth = true,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12.0,
    this.iconSpacing = 8.0,
    this.padding,
    this.isLoading = false,
    this.fontSize,
    this.splashColor,
    this.elevation = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeConfig = _sizeConfigs[size]!;

    // Default colors based on variant
    Color bgColor, labelColor, borderColor;
    switch (variant) {
      case ButtonVariant.primary:
        bgColor = AppColors.blue;
        labelColor = AppColors.white;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.secondary:
        bgColor = AppColors.blue.withOpacity(0.1);
        labelColor = AppColors.blue;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.outline:
        bgColor = Colors.transparent;
        labelColor = AppColors.blue;
        borderColor = AppColors.blue;
        break;
      case ButtonVariant.text:
        bgColor = Colors.transparent;
        labelColor = AppColors.blue;
        borderColor = Colors.transparent;
        break;
    }

    final effectiveBgColor = backgroundColor ?? bgColor;
    final effectiveTextColor = textColor ?? labelColor;
    final effectivePadding = padding ?? sizeConfig.padding;

    final isDisabled = onPressed == null;

    // Disabled state overrides
    if (isDisabled) {
      bgColor = (variant == ButtonVariant.outline || variant == ButtonVariant.text)
          ? Colors.transparent
          : Colors.grey.shade300;
      labelColor = Colors.grey;
      borderColor = variant == ButtonVariant.outline ? Colors.grey : Colors.transparent;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        width: isFullWidth ? double.infinity : null,
        child: Material(
          color: isDisabled ? bgColor : effectiveBgColor,
          elevation: elevation,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            splashColor: splashColor,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: effectivePadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isDisabled
                      ? borderColor
                      : (variant == ButtonVariant.outline ? effectiveTextColor : borderColor),
                  width: variant == ButtonVariant.outline ? 1.5 : 0,
                ),
              ),
              child: isLoading
                  ? _buildLoadingIndicator(labelColor)
                  : _buildContent(sizeConfig, isDisabled ? labelColor : effectiveTextColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(Color color) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }

  Widget _buildContent(_ButtonSizeConfig config, Color textColor) {
    final hasPrefix = prefixIcon != null;
    final hasSuffix = suffixIcon != null;

    return Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasPrefix)
          Icon(prefixIcon, size: config.iconSize, color: textColor),
        if (hasPrefix) SizedBox(width: iconSpacing),
        Text(
          label,
          style: AppStyle.fieldText.copyWith(
            color: textColor,
            fontSize: fontSize ?? config.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (hasSuffix) SizedBox(width: iconSpacing),
        if (hasSuffix)
          Icon(suffixIcon, size: config.iconSize, color: textColor),
      ],
    );
  }

  /// Size configuration lookup
  static final Map<ButtonSize, _ButtonSizeConfig> _sizeConfigs = {
    ButtonSize.small: const _ButtonSizeConfig(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      fontSize: 12,
      iconSize: 16,
    ),
    ButtonSize.medium: const _ButtonSizeConfig(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      fontSize: 14,
      iconSize: 18,
    ),
    ButtonSize.large: const _ButtonSizeConfig(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      fontSize: 16,
      iconSize: 20,
    ),
  };
}

/// Internal config for button size
class _ButtonSizeConfig {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double iconSize;

  const _ButtonSizeConfig({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
  });
}
