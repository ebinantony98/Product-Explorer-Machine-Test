import 'package:flutter/material.dart';
import 'package:product_explorer/controllers/product_controller.dart';
import 'package:product_explorer/views/screens/product_detail_screen.dart';
import 'package:product_explorer/widgets/product_card.dart';
import 'package:product_explorer/widgets/state_views.dart';

Widget buildBody(
  BuildContext context,
  ProductController controller,
  List products,
) {
  if (controller.status == ProductStatus.loading && products.isEmpty) {
    return const LoadingView();
  }
  if (controller.status == ProductStatus.error) {
    return ErrorView(
      message: controller.errorMessage ?? 'Please try again.',
      onRetry: controller.refresh,
    );
  }
  if (controller.status == ProductStatus.empty || products.isEmpty) {
    return const EmptyView();
  }
  return RefreshIndicator(
    onRefresh: controller.refresh,
    child: GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: .66,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          ),
        );
      },
    ),
  );
}
