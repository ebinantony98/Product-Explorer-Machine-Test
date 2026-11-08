import 'package:flutter/material.dart';
import 'package:product_explorer/utils/app_theme.dart';

class ProductReviewCard extends StatelessWidget {
  const ProductReviewCard({super.key, required this.review});

  final Map<String, dynamic> review;

  String get reviewerName =>
      review['reviewerName']?.toString().trim().isNotEmpty == true
      ? review['reviewerName'].toString().trim()
      : 'Anonymous';

  String get comment => review['comment']?.toString().trim().isNotEmpty == true
      ? review['comment'].toString().trim()
      : 'No comment provided.';

  int get rating {
    final value = review['rating'];
    final number = value is num ? value : num.tryParse('$value');
    return number?.round().clamp(1, 5) ?? 0;
  }

  String get formattedDate {
    final value = review['date']?.toString() ?? '';
    final date = DateTime.tryParse(value);
    if (date == null) return '';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String get initials {
    final words = reviewerName
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty);
    final letters = words.take(2).map((word) => word[0].toUpperCase()).join();
    return letters.isEmpty ? 'A' : letters;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECECF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.accent.withValues(alpha: 0.12),
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppTheme.accent,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    if (formattedDate.isNotEmpty)
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          color: AppTheme.muted,
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ),
              if (rating > 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 17,
                      color: const Color(0xFFFFB547),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(comment, style: const TextStyle(height: 1.45)),
        ],
      ),
    );
  }
}
