import 'package:flutter_test/flutter_test.dart';
import 'package:product_explorer/models/product.dart';

void main() {
  test('parses product and calculates discounted price', () {
    final product = Product.fromJson({
      'id': 7, 'title': 'Phone', 'price': 200, 'discountPercentage': 15,
      'rating': 4.4, 'stock': 10, 'images': ['a', 'b'],
    });

    expect(product.id, 7);
    expect(product.title, 'Phone');
    expect(product.discountedPrice, 170);
    expect(product.images, ['a', 'b']);
    expect(product.brand, 'Unbranded');
  });

  test('serializes and restores a product', () {
    final original = Product.fromJson({'id': 1, 'title': 'Sample', 'price': 25});
    final restored = Product.fromJson(original.toJson());
    expect(restored.id, original.id);
    expect(restored.title, original.title);
    expect(restored.price, original.price);
  });
}
