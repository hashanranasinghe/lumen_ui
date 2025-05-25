import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';

/// A custom radio selection widget for selecting marital status.
///
/// It shows options like "Single", "Married", and "Divorced" with custom
/// styling, icons, and description. The selected option is highlighted.
class Template extends StatefulWidget {
  final Function(String) onChange;      // Callback when a status is selected
  final String selectedStatus;          // Currently selected status

  const Template({
    super.key,
    required this.onChange,
    required this.selectedStatus,
  });

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  // List of marital status options with title, subtitle, and icons
  final List<Map<String, dynamic>> statusOptions = [
    {
      'value': 'Single',
      'title': 'Single',
      'subtitle': 'Not currently married',
      'icon': Icons.person_outline,
    },
    {
      'value': 'Married',
      'title': 'Married',
      'subtitle': 'Currently married',
      'icon': Icons.favorite_outline,
    },
    {
      'value': 'Divorced',
      'title': 'Divorced',
      'subtitle': 'Previously married',
      'icon': Icons.heart_broken_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section title
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Marital Status',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
            ),
          ),

          // Generate each status option
          ...statusOptions.map((option) => _buildCustomRadioTile(
                value: option['value'],
                title: option['title'],
                subtitle: option['subtitle'],
                icon: option['icon'],
              )),
        ],
      ),
    );
  }

  /// Helper to build each custom-styled radio tile.
  Widget _buildCustomRadioTile({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool isSelected = widget.selectedStatus == value;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => widget.onChange(value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.appPrimary
                    : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected
                  ? AppColors.appPrimary.withOpacity(0.05)
                  : Colors.grey[50],
            ),
            child: Row(
              children: [
                // Left icon circle
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.appPrimary.withOpacity(0.1)
                        : Colors.grey[200],
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? AppColors.appPrimary
                        : Colors.grey[600],
                    size: 20,
                  ),
                ),

                const SizedBox(width: 16),

                // Text section (title and subtitle)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.appPrimary
                              : Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Right radio indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.appPrimary
                          : Colors.grey[400]!,
                      width: 2,
                    ),
                    color:
                        isSelected ? AppColors.appPrimary : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///
/// ### Example Usage:
/// ```dart
/// Statusselection(
///   selectedStatus: 'Single',
///   onChange: (value) {
///     print("Selected status: $value");
///   },
/// );
/// ```
