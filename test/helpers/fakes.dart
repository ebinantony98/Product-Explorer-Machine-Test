import 'package:product_explorer/models/product.dart';
import 'package:product_explorer/services/product_cache_service.dart';
import 'package:product_explorer/services/product_service.dart';

Product sampleProduct({
  int id = 1,
  String title = 'Test phone',
  String category = 'smartphones',
}) => Product.fromJson({
  'id': id, 'title': title, 'description': 'A test product', 'category': category,
  'price': 100, 'discountPercentage': 10, 'rating': 4.5, 'stock': 5,
  'brand': 'Example', 'thumbnail': 'https://example.com/image.jpg',
  'images': ['https://example.com/image.jpg'], 'tags': ['phone'],
});

class FakeRepository implements ProductRepository {
  FakeRepository(this.result);
  List<Product> result;
  bool shouldFail = false;

  @override
  Future<List<Product>> fetchProducts() async {
    if (shouldFail) throw Exception('Network unavailable');
    return result;
  }
}

class FakeCache implements ProductCache {
  List<Product>? cached;
  @override
  Future<List<Product>?> readProducts() async => cached;
  @override
  Future<void> writeProducts(List<Product> products) async => cached = products;
}
