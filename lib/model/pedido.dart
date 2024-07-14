import 'package:f05_eshop/model/itemCart.dart';
import 'package:f05_eshop/model/product.dart';

class Pedido {
  List<ItemCart> produtos;
  double total;
  DateTime data;

  Pedido({required this.produtos, required this.total, required this.data});

  factory Pedido.fromJson(Map<String, dynamic> json) {
    List<ItemCart> items = [];
    if (json['produtos'] != null) {
      json['produtos'].forEach((item) {
        items.add(ItemCart.fromJson(item));
      });
      DateTime data = DateTime.parse(json['data']);
      return Pedido(produtos: items, total: json['total'], data: data);
    } else {
      throw Exception("Não foi possível acessar os produtos");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'data': data.toIso8601String(),
      'produtos': produtos.map((item) => item.toJson()).toList()
    };
  }
}
