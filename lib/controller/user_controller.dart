import 'dart:convert';

import 'package:f05_eshop/controller/produto_controller.dart';
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
          } else if (!(value['pedidos'] is List)) {}

          users.add(user);
        });
      } else {
        throw Exception("BOdy nulo");
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

  static Future<bool> addToFavorites(String id, Product produto) async {
    final List<User> users = await getUsers();
    User user = users.firstWhere((user) => user.id == id);
    List<Product> favoritos = await getFavorites(id) ?? [];

    if (user != null) {
      produto.toggleFavorite();
      favoritos.add(produto);
      user.favoritos = favoritos;
      updateUser(user);
      ProdutoController.updateProduct(produto);
      return true;
    }

    return false;
  }

  static Future<List<Product>> getFavorites(String id) async {
    final response = await http.get(
      Uri.parse(
          'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/user/$id/favoritos.json'),
    );

    List<Product> favoritos = [];

    if (response.statusCode == 200) {
      if (response.body != null) {
        final dynamic jbody = jsonDecode(response.body);

        if (jbody != null && jbody is List) {
          jbody.forEach((prod) {
            if (prod is Map<String, dynamic>) {
              Product produto = Product(
                id: prod['id'] ?? '',
                title: prod['title'] ?? '',
                description: prod['description'] ?? '',
                price: prod['price'] ?? 0.0,
                imageUrl: prod['imageUrl'] ?? '',
                isFavorite: prod['isFavorite'] ?? false,
              );
              favoritos.add(produto);
            }
          });
        } else {
          throw Exception("Corpo da resposta não é uma lista válida");
        }
      } else {
        throw Exception("Corpo da resposta é nulo");
      }
    } else {
      throw Exception(
          "Erro ao buscar favoritos. Status code: ${response.statusCode}");
    }
    return favoritos;
  }

  static Future<bool> isFavorite(String user_id, String title) async {
    List<Product> favorites = await getFavorites(user_id);

    if (!favorites.isEmpty) {
      return favorites.any((produto) => produto.title == title);
    }
    return false;
  }

  static Future<bool> removeToFavorites(String id, Product produto) async {
    List<User> users = await getUsers();
    User user = users.firstWhere((user) => user.id == id);
    List<Product> favoritos = await getFavorites(id);

    if (!favoritos.isEmpty) {
      // Crie uma cópia da lista favoritos para manipulação
      List<Product> copiaFavoritos = List.from(favoritos);

      Product prod_search =
          copiaFavoritos.firstWhere((prod) => prod.title == produto.title);
      prod_search.toggleFavorite();
      copiaFavoritos.remove(prod_search);
      produto.isFavorite = false;
      ProdutoController.updateProduct(produto);

      // Atualize o usuário apenas se a remoção for bem-sucedida
      user.favoritos = copiaFavoritos;
      updateUser(user);
      return true;
    }
    return false;
  }
}
