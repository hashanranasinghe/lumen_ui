import 'package:flutter/material.dart';
import 'package:example/ui/styles/color.dart';
import 'package:example/ui/styles/styles.dart';

/// A beautifully redesigned app bar with back button functionality.
///
/// This app bar provides a modern, clean design with smooth transitions
/// and subtle visual effects while maintaining all the functionality
/// of a standard app bar.
///
/// ### Parameters:
/// - [title]: Title displayed at the center or start of the app bar.
/// - [onBackPress]: Callback when back button is pressed. Defaults to Navigator.pop().
/// - [actions]: Optional list of action widgets (e.g. icons) aligned to the end.
/// - [leading]: Custom leading widget (overrides default back button).
/// - [elevation]: Elevation for drop shadow effect. Default is `0.5`.
/// - [backgroundColor]: Background color of the app bar. Default is `AppColors.appPrimary`.
/// - [titleStyle]: Optional custom text style for the title.
/// - [centerTitle]: Whether to center the title. Default is `true`.
/// - [height]: Custom height for the app bar. Default is `kToolbarHeight`.
/// - [flexibleSpace]: Optional flexible space (behind the content).
///
/// ### Example Usage:
/// ```dart
/// BackButtonAppBar(
///   title: "Profile",
///   onBackPress: () {
///     print("Back pressed");
///   },
///   actions: [
///     IconButton(
///       icon: Icon(Icons.settings, color: Colors.white),
///       onPressed: () {},
///     )
///   ],
/// )
/// ```
class BackButtonAppBar extends StatelessWidget implements PreferredSizeWidget {
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

  const BackButtonAppBar({
    Key? key,
    required this.title,
    this.onBackPress,
    this.actions,
    this.leading,
    this.elevation = 0.5,
    this.backgroundColor = AppColors.appPrimary,
    this.titleStyle,
    this.centerTitle = true,
    this.height = kToolbarHeight,
    this.flexibleSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: elevation * 3,
                  spreadRadius: elevation / 2,
                ),
              ]
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Custom back button with animation
              Positioned(
                left: 4,
                child: _buildLeadingButton(context),
              ),

              // Title
              if (centerTitle)
                Center(child: _buildTitle())
              else
                Positioned(
                  left: 56,
                  right: actions != null ? 56 : 16,
                  child: _buildTitle(),
                ),

              // Actions
              if (actions != null)
                Positioned(
                  right: 4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ),
                ),

              // Optional flexible background
              if (flexibleSpace != null)
                Positioned.fill(
                  child: flexibleSpace!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the leading button (typically back button)
  Widget _buildLeadingButton(BuildContext context) {
    return leading ??
        Container(
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
              size: 20,
            ),
            splashRadius: 24,
            onPressed: onBackPress ?? () => Navigator.of(context).pop(),
          ),
        );
  }

  /// Builds the title widget with text overflow handling
  Widget _buildTitle() {
    return Text(
      title,
      style: titleStyle ??
          AppStyle.textHeadline5Reg.copyWith(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.3,
          ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
