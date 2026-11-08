import 'package:flutter/material.dart';
import 'package:product_explorer/utils/app_theme.dart';
import 'package:product_explorer/widgets/product_review_card.dart';

class ProductReviewsSection extends StatelessWidget {
  const ProductReviewsSection({super.key, required this.reviews});

  final List<Map<String, dynamic>> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Row(
          children: [
            const Text(
              'Customer Reviews',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const Spacer(),
            if (reviews.isNotEmpty)
              Text(
                '${reviews.length} reviews',
                style: const TextStyle(color: AppTheme.muted, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (reviews.isEmpty)
          const Text(
            'No reviews have been added for this product yet.',
            style: TextStyle(color: AppTheme.muted),
          )
        else
          ...reviews.map((review) => ProductReviewCard(review: review)),
      ],
    );
  }
}
