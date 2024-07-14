import 'dart:convert';

import 'package:f05_eshop/model/itemCart.dart';
import 'package:f05_eshop/model/pedido.dart';
import 'package:f05_eshop/model/product.dart';
import 'package:f05_eshop/model/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  UserController();

  static String url =
      'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/user.json';

  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(url));

    final List<User> users = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> jbody = jsonDecode(response.body);
      if (jbody != null) {
        jbody.forEach((key, value) {
          User user = new User(
            id: key,
            name: value['name'] ??
                '', // Se 'name' for nulo, atribui uma string vazia
            email: value['email'] ??
                '', // Se 'email' for nulo, atribui uma string vazia
            password: value['password'] ??
                '', // Se 'password' for nulo, atribui uma string vazia
          );
          if (value['pedidos'] != null && value['pedidos'] is List) {
            List<Pedido> pedidos = [];
            value['pedidos'].forEach((pedido) {
              pedidos.add(Pedido.fromJson(pedido));
            });
            user.pedidos = pedidos;
          } else if (!(value['pedidos'] is List)) {
            print("Não é uma lista");
          }

          users.add(user);
        });
      } else {
        print("BOdy nulo");
      }

      if (users.isEmpty) {
        throw Exception("Não há usuários cadastrados!");
      }
      return users;
    }

    throw Exception("Não foi possível retornar a lista de usuários!");
  }

  static Future<User> existUser(String email, String password) async {
    final List<User> users = await getUsers();
    return users
        .firstWhere((user) => user.email == email && user.password == password);
  }

  static Future<bool> saveUser(User user) async {
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'password': user.password,
          'pedidos': user.pedidos
        }));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception("ERRO: Não foi possível salvar o usuário!");
  }

  static Future<bool> updateUser(User user) async {
    String id = user.id;
    final response = await http.put(
        Uri.parse(
            'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/user/$id.json'),
        body: jsonEncode(user.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception("Não foi possível atualizar o usuário");
  }

  static void addPedido(String email, String password, Pedido pedido) async {
    User user = await existUser(email, password);
    if (user.pedidos == null) {
      user.pedidos = [];
    }
    user.pedidos!.add(pedido);
    updateUser(user);
  }

  static Future<List<Pedido>> getPedidos(String id) async {
    final response = await http.get(
      Uri.parse(
          'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/user/$id/pedidos.json'),
    );

    if (response.statusCode == 200) {
      List<Pedido> pedidos = [];

      if (response.body != null) {
        List<dynamic> jbody = jsonDecode(response.body);

        jbody.forEach((item) {
          List<ItemCart> items = [];
          item['produtos'].forEach((item) {
            Product produto = new Product(
                id: id,
                title: item['product']['title'],
                description: item['product']['description'],
                price: item['product']['price'],
                imageUrl: item['product']['imageUrl'],
                isCartShop: item['product']['isCartShop'],
                isFavorite: item['product']['isFavorite']);
            ItemCart itemCart =
                new ItemCart(product: produto, quantidade: item['quantidade']);

            items.add(itemCart);
          });
          DateTime data = DateTime.parse(item['data']);
          Pedido pedido =
              new Pedido(produtos: items, total: item['total'], data: data);

          pedidos.add(pedido);
        });

        return pedidos;
      } else {
        return [];
      }
    }
    throw Exception("Não foi possível retornar os pedidos do usuário!");
  }
}
