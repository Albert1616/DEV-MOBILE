import 'dart:math';

import 'package:f05_eshop/model/pedido.dart';

class User {
  final String id;
  String name;
  String email;
  String password;
  List<Pedido>? pedidos;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.pedidos});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.pedidos != null) {
      data['pedidos'] = this.pedidos!.map((pedido) => pedido.toJson()).toList();
    }
    return data;
  }
}
