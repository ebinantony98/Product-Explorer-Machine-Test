import 'package:flutter/material.dart';
import 'package:product_explorer/utils/app_theme.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: ChoiceChip(
      label: Text(label[0].toUpperCase() + label.substring(1)),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      backgroundColor: Colors.white,
      selectedColor: AppTheme.ink,
      labelStyle: TextStyle(
        color: selected ? Colors.white : AppTheme.muted,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
    ),
  );
}
