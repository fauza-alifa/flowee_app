import 'package:flowee_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

/**
 * this widget won't safe text that we type manually
 * everytime users type, 'onChanged will be called and the homescreen wil safe it and use it
 * to filter the product's data, this is another example of 'lifting state up'
 */
class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Cari mawar, tulip atau anggrek...',
        hintStyle: TextStyle(color: AppTheme.textSecondary, fontSize: 13.5),
        prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
