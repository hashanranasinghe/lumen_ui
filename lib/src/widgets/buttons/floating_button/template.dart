import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A customizable expandable floating action button with multiple options.
/// 
/// This widget implements an expandable floating action button (FAB) that reveals
/// multiple action buttons when expanded. The main button toggles expansion, and
/// when expanded, displays smaller action buttons with labels vertically above it.
/// 
/// This pattern follows Material Design's speed dial FAB pattern, providing quick
/// access to multiple related actions without cluttering the UI when not needed.
/// 
/// 
/// ### Parameters:
/// - [isFabExpanded] (required): Controls whether the secondary buttons are shown.
/// - [toggleFab] (required): Function called when the main FAB is tapped.
/// - [createFolder] (required): Function called when the "Create" button is tapped.
/// - [uploadFile] (required): Function called when the "Upload" button is tapped.
/// - [longSelect] (required): Function called when the "Select" button is tapped.
/// - [mainButtonColor]: Color of the main floating action button. Default is `AppColors.primary`.
/// - [spacing]: Vertical spacing between buttons as a fraction of screen height. Default is `0.02`.
/// - [buttonPadding]: Padding around the entire widget as fractions of screen dimensions.
class Template extends StatelessWidget {
  final bool isFabExpanded;
  final VoidCallback toggleFab;
  final VoidCallback createFolder;
  final VoidCallback uploadFile;
  final VoidCallback longSelect;
  final Color mainButtonColor;
  final double spacing;
  final EdgeInsetsGeometry? buttonPadding;

  const Template({
    Key? key,
    required this.isFabExpanded,
    required this.toggleFab,
    required this.createFolder,
    required this.uploadFile,
    required this.longSelect,
    this.mainButtonColor = AppColors.primary,
    this.spacing = 0.02,
    this.buttonPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Default padding if not provided
    final EdgeInsetsGeometry padding = buttonPadding ?? 
        EdgeInsets.only(bottom: size.height * 0.07, right: size.width * 0.05);
    
    // Calculate spacing between buttons
    final double buttonSpacing = size.height * spacing;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show secondary buttons only when expanded
          isFabExpanded
              ? Column(
                  key: const ValueKey<String>('expanded_buttons'),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Create folder button
                    FloatingSmallButton(
                      onTap: () {
                        createFolder();
                        toggleFab();
                      },
                      title: "Create",
                      icon: CupertinoIcons.folder_badge_plus,
                    ),
                    SizedBox(height: buttonSpacing),
                    
                    // Upload file button
                    FloatingSmallButton(
                      onTap: () {
                        uploadFile();
                        toggleFab();
                      },
                      title: "Upload",
                      icon: CupertinoIcons.cloud_upload,
                    ),
                    SizedBox(height: buttonSpacing),
                    
                    // Select button
                    FloatingSmallButton(
                      onTap: () {
                        longSelect();
                        toggleFab();
                      },
                      title: "Select",
                      icon: CupertinoIcons.check_mark_circled,
                    ),
                    SizedBox(height: buttonSpacing),
                  ],
                )
              : const SizedBox.shrink(),
          
          // Main floating action button
          FloatingActionButton(
            elevation: 4.0,
            backgroundColor: mainButtonColor,
            onPressed: toggleFab,
            child: Icon(
              // Change icon based on expanded state
              isFabExpanded
                  ? CupertinoIcons.folder_fill_badge_minus
                  : CupertinoIcons.folder_fill_badge_plus,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// A small floating action button with an accompanying label.
/// 
/// This widget creates a combination of a text label and a small floating action
/// button, typically used as a secondary action in an expandable FAB. The label
/// appears as a pill-shaped container to the left of the button.
/// 
/// ### Features:
/// - Text label with customizable content
/// - Small floating action button with custom icon
/// - Consistent styling with subtle shadow effects
/// - Responsive sizing based on screen dimensions
/// 
/// ### Parameters:
/// - [onTap] (required): Function called when the button is tapped.
/// - [title] (required): Text to display in the label.
/// - [icon] (required): Icon to display in the small FAB.
/// - [buttonColor]: Background color of the small FAB. Default is `AppColors.white`.
/// - [iconColor]: Color of the icon. Default is `AppColors.primary`.
/// - [labelColor]: Background color of the label. Default is `AppColors.white`.
/// - [textStyle]: Style for the label text. Default is size 12.
/// - [labelPadding]: Padding for the label text. Default is `EdgeInsets.symmetric(vertical: 4, horizontal: 16)`.
class FloatingSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Color buttonColor;
  final Color iconColor;
  final Color labelColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry labelPadding;

  const FloatingSmallButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.buttonColor = AppColors.white,
    this.iconColor = AppColors.primary,
    this.labelColor = AppColors.white,
    this.textStyle,
    this.labelPadding = const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Default text style if not provided
    final TextStyle effectiveTextStyle = textStyle ?? 
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label container with shadow
        Container(
          padding: labelPadding,
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 0.5,
                color: AppColors.gray,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            title,
            style: effectiveTextStyle,
          ),
        ),
        
        // Small spacing between label and button
        SizedBox(width: size.width * 0.01),
        
        // Small floating action button
        FloatingActionButton.small(
          backgroundColor: buttonColor,
          heroTag: null, // Prevent hero animation conflicts
          elevation: 4.0,
          onPressed: onTap,
          child: Icon(icon, color: iconColor),
        ),
      ],
    );
  }
}

/// ### Example Usage:
/// ```dart
/// bool _isExpanded = false;
/// 
/// FloatingButton(
///   isFabExpanded: _isExpanded,
///   toggleFab: () {
///     setState(() {
///       _isExpanded = !_isExpanded;
///     });
///   },
///   createFolder: () {
///     // Show folder creation dialog
///     showDialog(...);
///   },
///   uploadFile: () {
///     // Handle file upload
///     _pickAndUploadFile();
///   },
///   longSelect: () {
///     // Enable multiple selection mode
///     setState(() {
///       _isSelectionModeEnabled = true;
///     });
///   },
/// )
/// `