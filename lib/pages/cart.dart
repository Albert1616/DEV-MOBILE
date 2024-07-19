import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:f05_eshop/controller/user_controller.dart';
import 'package:f05_eshop/model/cart.store.dart';
import 'package:f05_eshop/model/itemCart.dart';
import 'package:f05_eshop/model/pedido.dart';
import 'package:f05_eshop/model/product.dart';
import 'package:f05_eshop/model/user.dart';
import 'package:f05_eshop/model/user.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartModelX = Provider.of<CartModelX>(context);
    final userModelX = Provider.of<UserModelX>(context);

    double price = cartModelX.calcTotal();

    _updateQtd(String id, String type) {
      ItemCart item =
          cartModelX.getProducts.firstWhere((item) => item.product.id == id);
      if (type == 'increment') {
        setState(() {
          item.quantidade++;
          price = cartModelX.calcTotal();
        });
      } else if (type == 'decrement') {
        if (item.quantidade > 0) {
          setState(() {
            item.quantidade--;
            cartModelX.calcTotal();
          });
        }
      }
    }

    _removeItem(String id) {
      ItemCart item =
          cartModelX.getProducts.firstWhere((item) => item.product.id == id);
      Product produto = item.product;
      cartModelX.getProducts.remove(item);
      produto.isCartShop = false;
      ProdutoController.updateProduct(produto);

      setState(() {
        price = cartModelX.calcTotal();
      });
    }

    _createCard(ItemCart item) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.product.title,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Text('${item.product.price.toString()} R\$'),
                  SizedBox(width: 15),
                  Text(item.quantidade.toString() + 'X'),
                  IconButton(
                    onPressed: () => {_updateQtd(item.product.id, 'decrement')},
                    icon: Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: () => {_updateQtd(item.product.id, 'increment')},
                    icon: Icon(Icons.add),
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    onPressed: () => {_removeItem(item.product.id)},
                    icon: Icon(Icons.delete_forever),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    _createPedido() {
      if (userModelX.currentUser != null) {
        Pedido pedido = new Pedido(
            produtos: cartModelX.getProducts.toList(),
            total: price,
            data: DateTime.now());
        User user = userModelX.currentUser!;
        UserController.addPedido(user.email, user.password, pedido);
        cartModelX.clear();
        Navigator.pushNamed(context, '/pedidos');
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Você precisa estar logado para fazer pedidos"),
            backgroundColor: Colors.red,
          ));
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Observer(
                builder: (context) => Expanded(
                  child: ListView.builder(
                    itemCount: cartModelX.getProducts.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: 10), // Adjust margin as needed
                        child: _createCard(cartModelX.getProducts[index]),
                      );
                    },
                  ),
                ),
              ),
              Text('Total: ${price.toStringAsPrecision(6)} R\$'),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  _createPedido();
                },
                child: Text("Finalizar compra"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              )
            ])));
  }
}
