import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}

class ProductService implements ProductRepository {
  ProductService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static final Uri _productsUri = Uri.parse('https://dummyjson.com/products');

  @override
  Future<List<Product>> fetchProducts() async {
    final response = await _client.get(_productsUri).timeout(
          const Duration(seconds: 20),
        );

    if (response.statusCode != 200) {
      throw ProductApiException(
        'Unable to load products (HTTP ${response.statusCode}).',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic> || decoded['products'] is! List) {
      throw const ProductApiException('The server returned an invalid response.');
    }

    return (decoded['products'] as List)
        .whereType<Map>()
        .map((item) => Product.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  void dispose() => _client.close();
}

class ProductApiException implements Exception {
  const ProductApiException(this.message);
  final String message;

  @override
  String toString() => message;
}
