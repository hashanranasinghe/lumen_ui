import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

class Template extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String profileImageUrl;

  const Template({
    Key? key,
    required this.title,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.md_theme_light_surface,
      elevation: 0,
      title: Text(
        title,
        style: AppStyle.textHeadline5Reg.copyWith(
          color: AppColors.md_theme_light_onSurface,
        ),
      ),
      centerTitle: true,
      actions: [
        CircleAvatar(
          backgroundImage: NetworkImage(profileImageUrl),
          radius: 18,
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
