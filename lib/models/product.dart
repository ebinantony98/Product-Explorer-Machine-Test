class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.thumbnail,
    required this.images,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final Map<String, dynamic> dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Map<String, dynamic>> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final String thumbnail;
  final List<String> images;

  double get discountedPrice => price * (1 - discountPercentage / 100);

  factory Product.fromJson(Map<String, dynamic> json) {
    double asDouble(dynamic value) =>
        value is num ? value.toDouble() : double.tryParse('$value') ?? 0;
    int asInt(dynamic value) =>
        value is num ? value.toInt() : int.tryParse('$value') ?? 0;

    return Product(
      id: asInt(json['id']),
      title: json['title']?.toString() ?? 'Untitled product',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Uncategorized',
      price: asDouble(json['price']),
      discountPercentage: asDouble(json['discountPercentage']),
      rating: asDouble(json['rating']),
      stock: asInt(json['stock']),
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      brand: json['brand']?.toString() ?? 'Unbranded',
      sku: json['sku']?.toString() ?? '',
      weight: asDouble(json['weight']),
      dimensions: Map<String, dynamic>.from(
        json['dimensions'] is Map ? json['dimensions'] as Map : {},
      ),
      warrantyInformation: json['warrantyInformation']?.toString() ?? '',
      shippingInformation: json['shippingInformation']?.toString() ?? '',
      availabilityStatus: json['availabilityStatus']?.toString() ?? '',
      reviews: (json['reviews'] as List?)
              ?.whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy']?.toString() ?? '',
      minimumOrderQuantity: asInt(json['minimumOrderQuantity']),
      thumbnail: json['thumbnail']?.toString() ?? '',
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'tags': tags,
        'brand': brand,
        'sku': sku,
        'weight': weight,
        'dimensions': dimensions,
        'warrantyInformation': warrantyInformation,
        'shippingInformation': shippingInformation,
        'availabilityStatus': availabilityStatus,
        'reviews': reviews,
        'returnPolicy': returnPolicy,
        'minimumOrderQuantity': minimumOrderQuantity,
        'thumbnail': thumbnail,
        'images': images,
      };
}
