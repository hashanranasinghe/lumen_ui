import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
/// A toggleable card-style list item with an icon, title, optional subtitle, and switch.
/// 
/// The `Togglecard` widget is ideal for displaying settings or preferences
/// where users can enable or disable features. It includes a leading icon,
/// a title, an optional subtitle, and a Cupertino-style toggle switch on the trailing edge.
/// 
/// The card has rounded corners and a customizable icon background color.
/// 
/// ### Parameters:
/// - [onToggle] (required): Callback function triggered when the switch is toggled.
/// - [color] (required): Background color of the icon circle.
/// - [title] (required): Title text displayed next to the icon.
/// - [iconData] (required): Icon to be displayed inside the colored circle.
/// - [initialValue]: Initial state of the toggle switch. Default is `false`.
/// - [subtitle]: Optional text displayed below the title, useful for additional context.
class Template extends StatelessWidget {
  final Function(bool) onToggle;
  final String title;
  final IconData iconData;
  final bool initialValue;
  final String? subtitle;
  final Color color;

  const Template({
    Key? key,
    required this.onToggle,
    required this.color,
    required this.title,
    required this.iconData,
    this.initialValue = false,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryContainer,
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  iconData,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
              subtitle: subtitle != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.gray,
                          letterSpacing: -0.2,
                        ),
                      ),
                    )
                  : null,
              trailing: CupertinoSwitch(
                value: initialValue,
                onChanged: onToggle,
                activeColor: AppColors.appPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ### Example Usage:
/// ```dart
/// Togglecard(
///   title: "Enable Notifications",
///   subtitle: "Receive push updates and alerts",
///   iconData: Icons.notifications_active,
///   color: Colors.orange,
///   initialValue: true,
///   onToggle: (value) {
///     print("Toggle switched: $value");
///   },
/// )
/// ```
