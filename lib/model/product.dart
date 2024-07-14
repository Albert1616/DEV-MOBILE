import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  bool isCartShop;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false,
      this.isCartShop = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void toggleCart() {
    isCartShop = !isCartShop;
    notifyListeners();
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      imageUrl: json['imageUrl'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      isCartShop: json['isCartShop'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'isCartShop': isCartShop
    };
  }
}
