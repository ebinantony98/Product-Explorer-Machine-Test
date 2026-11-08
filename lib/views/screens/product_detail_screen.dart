import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_explorer/controllers/product_controller.dart';
import 'package:product_explorer/models/product.dart';
import 'package:product_explorer/utils/app_theme.dart';
import 'package:product_explorer/widgets/infowidget.dart';
import 'package:product_explorer/widgets/product_reviews_section.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final gallery = product.images.isEmpty
        ? [product.thumbnail]
        : product.images;
    final imageIndex = _selectedImage.clamp(0, gallery.length - 1);
    final controller = context.watch<ProductController>();
    final isFavorite = controller.isFavorite(product.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(
              onPressed: () {
                controller.toggleFavorite(product.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      controller.isFavorite(product.id)
                          ? 'Added to favorites'
                          : 'Removed from favorites',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFavorite ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          Container(
            color: Colors.white,
            height: 310,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: gallery[imageIndex],
                    fit: BoxFit.contain,
                    placeholder: (_, _) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (_, _, _) => const Center(
                      child: Icon(Icons.image_not_supported_outlined, size: 42),
                    ),
                  ),
                ),
                if (product.discountPercentage > 0)
                  Positioned(
                    left: 20,
                    top: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (gallery.length > 1)
            SizedBox(
              height: 76,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: gallery.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => setState(() => _selectedImage = index),
                  child: Container(
                    width: 58,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: index == imageIndex
                            ? AppTheme.accent
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: gallery[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.accent,
                    letterSpacing: 1.5,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB547),
                      size: 19,
                    ),
                    Text(
                      ' ${product.rating.toStringAsFixed(1)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '  ·  ${product.reviews.length} reviews  ·  ${product.brand}',
                      style: const TextStyle(
                        color: AppTheme.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${product.discountedPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (product.discountPercentage > 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppTheme.muted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'About this product',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(product.description),
                const SizedBox(height: 20),
                const Text(
                  'Product information',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 10),
                InfoRow('Brand', product.brand),
                InfoRow('Category', product.category),
                InfoRow('Availability', product.availabilityStatus),
                InfoRow('Stock', '${product.stock} units'),
                InfoRow('Weight', '${product.weight} g'),
                InfoRow('Warranty', product.warrantyInformation),
                InfoRow('Shipping', product.shippingInformation),
                InfoRow('Returns', product.returnPolicy),
                if (product.tags.isNotEmpty)
                  InfoRow('Tags', product.tags.join(', ')),
                ProductReviewsSection(reviews: product.reviews),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
