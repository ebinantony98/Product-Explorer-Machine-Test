import 'package:flutter/material.dart';
import 'package:product_explorer/controllers/product_controller.dart';
import 'package:product_explorer/services/product_service.dart';
import 'package:product_explorer/utils/app_theme.dart';
import 'package:product_explorer/views/screens/product_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
   final service = ProductService();
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ProductController(service: service,),
      child: const ProductExplorerApp(),
    ),
  );
}

class ProductExplorerApp extends StatelessWidget {
  const ProductExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ProductListScreen(),
    );
  }
}
