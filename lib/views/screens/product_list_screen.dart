import 'package:flutter/material.dart';
import 'package:product_explorer/controllers/product_controller.dart';
import 'package:product_explorer/utils/app_theme.dart';
import 'package:product_explorer/views/screens/widgets/buildbody_widget.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

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
                      Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Icon(Icons.shopping_bag_outlined),
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
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    const Text('Products',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800)),
                    const Spacer(),
                    Text('${products.length} items',
                        style: const TextStyle(
                            color: AppTheme.muted, fontSize: 11)),
                  ]),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: buildBody(context, controller, products),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
