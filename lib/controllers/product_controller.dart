import 'package:flutter/material.dart';
import 'package:product_explorer/models/product.dart';
import 'package:product_explorer/services/product_service.dart';

enum ProductStatus { initial, loading, success, empty, error }

class ProductController extends ChangeNotifier {
  ProductController({required ProductRepository service}) : _service = service;

  final ProductRepository _service;

  List<Product> _products = [];
  ProductStatus _status = ProductStatus.initial;
  String? _errorMessage;
  String _searchQuery = '';
  String? _selectedCategory;
  bool _isOfflineData = false;

  List<Product> get products => List.unmodifiable(_products);
  ProductStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  bool get isOfflineData => _isOfflineData;

  Future<void> loadProducts({bool forceRefresh = false}) async {
    if (_status == ProductStatus.loading) return;

    _status = ProductStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final freshProducts = await _service.fetchProducts();
      _products = freshProducts;
      _isOfflineData = false;
      _status = freshProducts.isEmpty
          ? ProductStatus.empty
          : ProductStatus.success;
      _errorMessage = null;
    } catch (error) {
      if (_products.isNotEmpty) {
        _isOfflineData = true;
        _status = ProductStatus.success;
        _errorMessage = 'Could not refresh. Showing your saved products.';
      } else {
        _status = ProductStatus.error;
        _errorMessage = error.toString();
      }
    }
    notifyListeners();
  }

  List<Product> get visibleProducts {
    return _products.where((product) {
      final matchesQuery =
          product.title.toLowerCase().contains(_searchQuery) ||
          product.brand.toLowerCase().contains(_searchQuery) ||
          product.category.toLowerCase().contains(_searchQuery);
      final matchesCategory =
          _selectedCategory == null || product.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  Future<void> refresh() => loadProducts(forceRefresh: true);

  void updateSearch(String value) {
    _searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }
}
