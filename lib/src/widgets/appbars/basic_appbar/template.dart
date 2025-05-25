import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A redesigned basic app bar with improved aesthetics and modern styling.
///
/// This app bar provides a clean, contemporary look with subtle visual 
/// effects while maintaining full functionality of a standard app bar.
///
/// ### Parameters:
/// - [title]: The title string displayed in the app bar.
/// - [actions]: A list of widgets (typically icon buttons) displayed on the right side.
/// - [centerTitle]: Whether to center the title. Defaults to `true`.
/// - [backgroundColor]: Background color of the app bar. Default is `AppColors.lightGray`.
/// - [titleColor]: Color of the title text. Default is `AppColors.white`.
/// - [titleStyle]: Optional text style for the title.
/// - [elevation]: Elevation/shadow of the app bar. Default is `1`.
/// - [leading]: Custom leading widget (typically an icon).
/// - [automaticallyImplyLeading]: Whether to show a back button automatically if the Navigator can pop. Default is `true`.
/// - [height]: The height of the app bar. Default is `kToolbarHeight`.
/// - [bottom]: Optional widget displayed below the main app bar (like a tab bar).

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
    this.backgroundColor = AppColors.lightGray,
    this.titleColor = AppColors.white,
    this.titleStyle,
    this.elevation = 1,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.height = kToolbarHeight,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: elevation * 4,
                  spreadRadius: elevation / 3,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  // Leading widget or automatic back button
                  if (leading != null || automaticallyImplyLeading)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: leading ??
                          (Navigator.canPop(context)
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: AppColors.white,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                )
                              : null),
                    ),
                  
                  // Title with positioning based on centerTitle
                  Positioned(
                    left: centerTitle
                        ? 0
                        : (leading != null || (automaticallyImplyLeading && Navigator.canPop(context)))
                            ? 56
                            : 16,
                    right: centerTitle ? 0 : (actions != null ? 56 : 16),
                    child: Container(
                      height: height,
                      alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                      child: Text(
                        title,
                        style: titleStyle ??
                            AppStyle.textHeadline5Reg.copyWith(
                              color: titleColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  
                  // Actions positioned at the end
                  if (actions != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!.map((action) {
                          if (action is IconButton) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: action,
                            );
                          }
                          return action;
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),

            // Add bottom widget if provided (like TabBar)
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? height : height + bottom!.preferredSize.height);
}
///
/// ### Example Usage:
/// ```dart
/// BasicAppBar(
///   title: "Dashboard",
///   actions: [
///     IconButton(
///       icon: Icon(Icons.notifications, color: Colors.white),
///       onPressed: () {},
///     ),
///   ],
///   centerTitle: false,
/// )
/// ```