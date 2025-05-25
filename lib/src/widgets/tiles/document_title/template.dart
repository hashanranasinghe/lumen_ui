import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

// A stateless widget that displays a document item with metadata, icon, and download action
class Template extends StatelessWidget {
  final Function() onDownload; // Callback for download action
  final Function() onTap; // Callback when the card is tapped
  final String title; // Document title
  final String type; // File type (e.g., pdf, docx)
  final String date; // Document date
  final String size; // Document size (e.g., 2.4 MB)
  final String folderName; // Folder or category name

  const Template({
    super.key,
    required this.onDownload,
    required this.title,
    required this.type,
    required this.date,
    required this.size,
    required this.onTap,
    required this.folderName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 4), // Outer margin
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap, // Handle tap on the document card
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[200]!, // Light border
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // File type icon with label
                _buildFileTypeIndicator(),
                const SizedBox(width: 16),

                // Title and metadata
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title text with ellipsis if too long
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.textBody2Med.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Folder name, date, and size
                      _buildMetadataRow(),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Download icon button
                _buildDownloadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Builds the icon and file type indicator on the left
  Widget _buildFileTypeIndicator() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.appPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.appPrimary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon depending on file type
          Icon(
            _getFileIcon(),
            color: AppColors.appPrimary,
            size: 20,
          ),
          const SizedBox(height: 2),
          // File type abbreviation (e.g., PDF)
          Text(
            type.toUpperCase(),
            style: AppStyle.textBody2Med.copyWith(
              color: AppColors.appPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // Builds the metadata row: folder name, date, and size
  Widget _buildMetadataRow() {
    return Row(
      children: [
        // Folder name badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.appPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            folderName,
            style: AppStyle.textBody2Med.copyWith(
              fontSize: 11,
              color: AppColors.appPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Dot separator
        Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),

        // Date
        Flexible(
          child: Text(
            date,
            style: AppStyle.textBody2Reg.copyWith(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),

        // Dot separator
        Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),

        // File size
        Text(
          size,
          style: AppStyle.textBody2Reg.copyWith(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Builds the download button icon
  Widget _buildDownloadButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onDownload, // Call download callback
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.appPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.download_outlined,
            size: 20,
            color: AppColors.appPrimary,
          ),
        ),
      ),
    );
  }

  // Returns the icon based on file type
  IconData _getFileIcon() {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'doc':
      case 'docx':
        return Icons.description_outlined;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart_outlined;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow_outlined;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image_outlined;
      case 'mp4':
      case 'avi':
      case 'mov':
        return Icons.video_file_outlined;
      case 'mp3':
      case 'wav':
        return Icons.audio_file_outlined;
      case 'zip':
      case 'rar':
        return Icons.folder_zip_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}
// Example usage:
// DocumentTitle(
//   title: "My Document",
//   folderName: "Documents",
//   date: "May 20, 2023",
//   size: "2.5 MB",
//   type: "pdf",
//   onDownload: () {
//     // Handle download action
//   },
//   onTap: () {
//     // Handle tap action
//   },
// )
