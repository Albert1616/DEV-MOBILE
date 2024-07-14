import 'package:f05_eshop/model/product.dart';

class ItemCart {
  Product product;
  int quantidade;

  ItemCart({required this.product, required this.quantidade});

  factory ItemCart.fromJson(Map<String, dynamic> json) {
    return ItemCart(
        product: Product.fromJson(json['product']),
        quantidade: json['quantidade']);
  }

  Map<String, dynamic> toJson() {
    return {'quantidade': quantidade, 'product': product.toJson()};
  }
}
