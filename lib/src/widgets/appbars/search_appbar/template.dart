import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

class Template extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final VoidCallback? onClear;

  const Template({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.md_theme_light_surface,
      elevation: 0,
      title: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: AppStyle.hintText.copyWith(
            color: AppColors.md_theme_light_outline,
          ),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: AppColors.md_theme_light_primary),
            onPressed: onClear ?? () => controller.clear(),
          ),
        ),
        style: AppStyle.textBody1Reg.copyWith(
          color: AppColors.md_theme_light_onSurface,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.md_theme_light_primary,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}