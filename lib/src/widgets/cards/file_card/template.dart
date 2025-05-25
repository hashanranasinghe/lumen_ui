import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

/// A card widget that displays file information in a structured format.
/// 
/// This widget presents file metadata in a clean, organized card layout with
/// labeled fields for common file attributes like name, size, date, and uploader.
/// It can optionally display file content or preview when a URL is provided.
/// 
/// The card uses consistent styling with clear visual hierarchy between labels
/// and values, making it suitable for file browsers, document listings, or
/// file detail views.
/// 
/// 
/// ### Parameters:
/// - [name] (required): The name of the file.
/// - [size] (required): The size of the file (formatted string, e.g. "2.5 MB").
/// - [date] (required): The date associated with the file (often upload or modification date).
/// - [uploadedBy] (required): The name of the user who uploaded the file.
/// - [url]: Optional URL to the file or its preview.
/// - [showPreview]: Whether to show a preview area for the file. Default is `true`.
/// - [elevation]: Shadow elevation of the card. Default is `2.0`.
/// - [borderRadius]: Corner radius of the card. Default is `8.0`.
/// - [padding]: Internal padding of the card. Default is `EdgeInsets.all(15)`.
/// - [backgroundColor]: Background color of the card. Default is `Colors.white`.
/// - [labelColor]: Color of the label text. Default is `AppColors.appPrimary`.
/// - [valueColor]: Color of the value text. Default is `AppColors.lightGray`.
/// - [onTap]: Optional callback when the card is tapped.
/// - [previewBuilder]: Optional custom builder for the preview area.
class Template extends StatelessWidget {
  final String name;
  final String size;
  final String date;
  final String uploadedBy;
  final String? url;
  final bool showPreview;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color labelColor;
  final Color valueColor;
  final VoidCallback? onTap;
  final Widget Function(BuildContext, String?)? previewBuilder;

  const Template({
    Key? key,
    required this.name,
    required this.size,
    required this.date,
    required this.uploadedBy,
    this.url,
    this.showPreview = true,
    this.elevation = 2.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(15),
    this.backgroundColor = Colors.white,
    this.labelColor = AppColors.appPrimary,
    this.valueColor = AppColors.lightGray,
    this.onTap,
    this.previewBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: backgroundColor,
      clipBehavior: Clip.antiAlias, // Ensures content doesn't overflow rounded corners
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // File preview area (if URL is provided and preview is enabled)
              if (showPreview && url != null) ...[
                _buildPreviewArea(context),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
              ],
              
              // File metadata section
              _buildInfoRow(context, 'File name:', name),
              _buildInfoRow(context, 'Size:', size),
              _buildInfoRow(context, 'Date:', date),
              _buildInfoRow(context, 'Uploaded by:', uploadedBy),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the file preview area based on the file type
  Widget _buildPreviewArea(BuildContext context) {
    // Use custom preview builder if provided
    if (previewBuilder != null) {
      return previewBuilder!(context, url);
    }

    // Default preview based on file extension
    if (url != null) {
      final String extension = _getFileExtension(url!).toLowerCase();
      
      // For image files, show an image preview
      if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            width: double.infinity,
            child: Image.network(
              url!,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return _buildGenericFileIcon(extension);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        );
      }
      
      // For non-image files, show a generic file icon
      return _buildGenericFileIcon(extension);
    }
    
    return const SizedBox();
  }

  /// Builds a generic file icon with extension label
  Widget _buildGenericFileIcon(String extension) {
    return Container(
      height: 100,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getFileIcon(extension),
            size: 48,
            color: labelColor.withOpacity(0.8),
          ),
          const SizedBox(height: 8),
          Text(
            extension.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single info row with label and value
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '$label ',
              style: AppStyle.textBody2Med.copyWith(
                color: labelColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: AppStyle.textBody2Med.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get file extension from URL or file path
  String _getFileExtension(String url) {
    return url.split('.').last;
  }

  /// Get appropriate icon based on file extension
  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'txt':
        return Icons.text_snippet;
      case 'zip':
      case 'rar':
        return Icons.folder_zip;
      case 'mp3':
      case 'wav':
      case 'aac':
        return Icons.audiotrack;
      case 'mp4':
      case 'mov':
      case 'avi':
        return Icons.video_file;
      default:
        return Icons.insert_drive_file;
    }
  }
}

/// ### Example Usage:
/// ```dart
/// FileCard(
///   name: "Project Report.pdf",
///   size: "2.5 MB",
///   date: "19 May 2025",
///   uploadedBy: "John Smith",
///   url: "https://example.com/files/report.pdf",
///   onTap: () {
///     // Handle tap, e.g., open file or show details
///     openFile("https://example.com/files/report.pdf");
///   },
/// )
/// ```
/// 
/// ### Custom Preview Example:
/// ```dart
/// FileCard(
///   name: "Financial Data.xlsx",
///   size: "1.2 MB",
///   date: "15 May 2025",
///   uploadedBy: "Finance Team",
///   url: "https://example.com/files/data.xlsx",
///   previewBuilder: (context, url) {
///     return Container(
///       height: 100,
///       color: Colors.green.withOpacity(0.1),
///       child: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Icon(Icons.table_chart, size: 40, color: Colors.green),
///             Text("Excel Spreadsheet", style: TextStyle(color: Colors.green)),
///           ],
///         ),
///       ),
///     );
///   },
/// )
/// ```