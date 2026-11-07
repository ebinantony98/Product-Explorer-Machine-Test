import 'package:flutter/material.dart';
import 'package:product_explorer/controllers/product_controller.dart';
import 'package:product_explorer/utils/app_theme.dart';
import 'package:product_explorer/views/screens/widgets/buildbody_widget.dart';
import 'package:product_explorer/widgets/category.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<ProductController>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductController>(
          builder: (context, controller, _) {
            final products = controller.visibleProducts;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Explore Products',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onChanged: controller.updateSearch,
                    decoration: const InputDecoration(
                      hintText: 'Search products, brands...',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 38,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Category(
                        label: 'All',
                        selected: controller.selectedCategory == null,
                        onTap: () => controller.selectCategory(null),
                      ),
                      ...controller.categories.map(
                        (category) => Category(
                          label: category,
                          selected: controller.selectedCategory == category,
                          onTap: () => controller.selectCategory(category),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.isOfflineData)
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4DE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.cloud_off_outlined,
                          size: 16,
                          color: Color(0xFF9A6715),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            controller.errorMessage ??
                                'Offline mode · Showing saved products',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF805714),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${products.length} items',
                        style: const TextStyle(
                          color: AppTheme.muted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(child: buildBody(context, controller, products)),
              ],
            );
          },
        ),
      ),
    );
  }
}
