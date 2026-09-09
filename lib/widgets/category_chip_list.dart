import 'package:flowee_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (_, _) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => onSelected(category),
            // defining on selected action
            selectedColor: AppTheme.primaryDark,
            showCheckmark: false,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            backgroundColor: isSelected
                ? AppTheme.primary
                : AppTheme.primarySoft.withValues(alpha: 0.5),
            side: BorderSide.none,
            elevation: 0,
            pressElevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
          );
        },
      ),
    );
  }
}
