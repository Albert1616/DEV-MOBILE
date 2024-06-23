import 'dart:convert';

import 'package:f05_eshop/model/product.dart';
import 'package:http/http.dart' as http;

class ProdutoController {
  ProdutoController();

  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(
        'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/Produto'));

    if (response.statusCode == 200) {
      final lst = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return lst.map<Product>((item) => Product.fromJson(item)).toList();
    }

    throw Exception("Lista não pode ser encontrada!");
  }

  static Future<Product> saveProduct(Product product) async {
    final response = await http.post(
        Uri.parse(
            'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/produto.json'),
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
        body: jsonEncode({
          'id': product.id,
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
          'isCartShop': product.isCartShop
        }));
    if (response.statusCode == 200) {
      print("Salvo");
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("ERRO não foi possível salvar o produto!");
    }
  }

  static Future<Product> updateProduct(Product product) async {
    final response = await http.put(
        Uri.parse(
            'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/Produto'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': product.id,
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
          'isCartShop': product.isCartShop
        }));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("ERRO Não foi possível atualizar o produto!");
    }
  }
}
