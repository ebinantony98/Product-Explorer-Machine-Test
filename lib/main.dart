import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_explorer/controllers/product_controller.dart';
import 'package:product_explorer/services/product_cache_service.dart';
import 'package:product_explorer/services/product_service.dart';
import 'package:product_explorer/utils/app_theme.dart';
import 'package:product_explorer/views/screens/product_list_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final cache = ProductCacheService(
    await Hive.openBox<String>('product_cache'),
  );
  final service = ProductService();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductController(service: service, cache: cache),
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
