import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';


class Template extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const Template({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.md_theme_light_surface,
      elevation: 0, // No shadow for a modern look
      centerTitle: true,
      title: Text(
        title,
        style: AppStyle.textHeadline5Reg.copyWith(
          color: AppColors.md_theme_light_onSurface,
        ),
      ),
      actions: actions,
      iconTheme: IconThemeData(
        color: AppColors.md_theme_light_primary, // Icon color
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}