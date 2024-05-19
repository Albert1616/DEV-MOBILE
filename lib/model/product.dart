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
}
