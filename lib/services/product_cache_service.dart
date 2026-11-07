import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/product.dart';

abstract class ProductCache {
  Future<List<Product>?> readProducts();
  Future<void> writeProducts(List<Product> products);
}

class ProductCacheService implements ProductCache {
  ProductCacheService(this._box);

  final Box<String> _box;
  static const _productsKey = 'products';

  @override
  Future<List<Product>?> readProducts() async {
    final raw = _box.get(_productsKey);
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((item) => Product.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  @override
  Future<void> writeProducts(List<Product> products) async {
    final encoded = jsonEncode(
      products.map((product) => product.toJson()).toList(),
    );
    await _box.put(_productsKey, encoded);
  }
}
