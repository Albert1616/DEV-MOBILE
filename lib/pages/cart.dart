import 'package:f05_eshop/model/cart.store.dart';
import 'package:f05_eshop/model/cart.store.dart';
import 'package:f05_eshop/model/itemCart.dart';
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

    _updateQtd(String id, String type){
      ItemCart item = cartModelX.getProducts.firstWhere((item) => item.product.id == id);
      if(type == 'increment'){
        setState((){
          item.quantidade++;
          cartModelX.calcTotal();
        })
      }else if(type == 'decrement'){
        setState((){
          item.quantidade--;
          cartModelX.calcTotal();
        })
      }
    }

    _removeItem(String id){
      ItemCart item = cartModelX.getProducts.firstWhere((item) => item.product.id == id);
      cartModelX.getProducts.remove(item);
      cartModelX.calcTotal();
    }


  _createCard(ItemCart item){
  return Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.product.title,
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Text(item.product.price.toString()),
                  SizedBox(width: 15),
                  Text(item.quantidade.toString() + 'X'),
                  IconButton(
                      onPressed: () =>
                          {_updateQtd(item.product.id, 'decrement')},
                      icon: Icon(Icons.remove)),
                  IconButton(
                      onPressed: () => {_updateQtd(item.product.id, 'increment')},
                      icon: Icon(Icons.add)),
                  SizedBox(width: 15),
                  IconButton(
                    onPressed:()=>{

                    },
                    icon: Icon(Icons.trash)
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
    return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Observer(
                  builder: (context) => ListView.builder(
                        itemCount: cartModelX.getProducts.length,
                        itemBuilder: (ctx, index) {
                          return _createCard(cartModelX.getProducts[index]);
                        },
                      )),
              Text("Total: " + cartModelX.total.toString() + "R$");
            ])));
  }
}