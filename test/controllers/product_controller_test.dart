import 'package:flutter_test/flutter_test.dart';
import 'package:product_explorer/controllers/product_controller.dart';

import '../helpers/fakes.dart';

void main() {
  late FakeRepository repository;
  late FakeCache cache;
  late ProductController controller;

  setUp(() {
    repository = FakeRepository([sampleProduct()]);
    cache = FakeCache();
    controller = ProductController(service: repository, cache: cache);
  });

  tearDown(() => controller.dispose());

  test('loads products and saves them to cache', () async {
    await controller.loadProducts();
    expect(controller.status, ProductStatus.success);
    expect(controller.products.length, 1);
    expect(cache.cached?.length, 1);
    expect(controller.isOfflineData, isFalse);
  });

  test('uses cached products when network fails', () async {
    cache.cached = [sampleProduct()];
    repository.shouldFail = true;

    await controller.loadProducts();

    expect(controller.status, ProductStatus.success);
    expect(controller.isOfflineData, isTrue);
    expect(controller.products.length, 1);
  });

  test('exposes error when both network and cache are unavailable', () async {
    repository.shouldFail = true;
    await controller.loadProducts();

    expect(controller.status, ProductStatus.error);
    expect(controller.errorMessage, isNotNull);
  });

  test('filters products by search and category', () async {
    repository.result = [
      sampleProduct(title: 'Phone'),
      sampleProduct(id: 2, title: 'Laptop', category: 'laptops'),
    ];
    await controller.loadProducts();

    controller.selectCategory('laptops');
    controller.updateSearch('phone');
    expect(controller.visibleProducts.length, 1);
    expect(controller.selectedCategory, isNull);

    controller.updateSearch('');
    controller.selectCategory('smartphones');
    expect(controller.visibleProducts.length, 1);
  });
}
