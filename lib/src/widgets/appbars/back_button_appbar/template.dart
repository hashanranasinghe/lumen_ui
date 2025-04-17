import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

class Template extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;
  final List<Widget>? actions;
  final Widget? leading;
  final double elevation;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final double height;
  final Widget? flexibleSpace;

  const Template({
    Key? key,
    required this.title,
    this.onBackPress,
    this.actions,
    this.leading,
    this.elevation = 1.0,
    this.backgroundColor = AppColors.blue,
    this.titleStyle,
    this.centerTitle = true,
    this.height = kToolbarHeight,
    this.flexibleSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: leading ??
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
              size: 22,
            ),
            splashRadius: 24,
            onPressed: onBackPress ?? () => Navigator.of(context).pop(),
          ),
      title: Text(
        title,
        style: titleStyle ??
            AppStyle.textHeadline5Reg.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: centerTitle,
      actions: actions,
      flexibleSpace: flexibleSpace,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
