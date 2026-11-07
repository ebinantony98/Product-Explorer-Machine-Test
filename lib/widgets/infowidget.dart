import 'package:flutter/material.dart';
import 'package:product_explorer/utils/app_theme.dart';

class InfoRow extends StatelessWidget {
  const InfoRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 112, child: Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 12))),
          Expanded(child: Text(value.isEmpty ? 'Not specified' : value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
        ]),
      );
}