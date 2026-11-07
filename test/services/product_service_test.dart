import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:product_explorer/services/product_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late ProductService service;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    client = MockClient();
    service = ProductService(client: client);
  });

  test('returns parsed products for a successful response', () async {
    when(() => client.get(any())).thenAnswer((_) async => http.Response(
      jsonEncode({'products': [{'id': 1, 'title': 'Phone', 'price': 99}]}), 200,
    ));

    final products = await service.fetchProducts();
    expect(products, hasLength(1));
    expect(products.first.title, 'Phone');
  });

  test('throws a readable exception for non-200 response', () async {
    when(() => client.get(any())).thenAnswer((_) async => http.Response('Server error', 500));

    expect(service.fetchProducts(), throwsA(isA<ProductApiException>()));
  });

  test('rejects malformed response shape', () async {
    when(() => client.get(any())).thenAnswer((_) async => http.Response('[]', 200));

    expect(service.fetchProducts(), throwsA(isA<ProductApiException>()));
  });
}
