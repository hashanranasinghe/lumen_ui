import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';


class Template extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final TextStyle? titleStyle;
  final double elevation;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double height;
  final PreferredSizeWidget? bottom;

  const Template({
    Key? key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor = AppColors.green,
    this.titleColor = AppColors.white,
    this.titleStyle,
    this.elevation = 2,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.height = kToolbarHeight,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: Text(
        title,
        style: titleStyle ?? AppStyle.textHeadline5Reg.copyWith(
          color: titleColor,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
      iconTheme: IconThemeData(
        color: AppColors.md_theme_light_primary,
        size: 24,
      ),
      shape: elevation > 0 
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            )
          : null,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? height : height + bottom!.preferredSize.height);
}