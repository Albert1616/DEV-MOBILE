import 'package:f05_eshop/components/main_drawer.dart';
import 'package:f05_eshop/model/itemCart.dart';
import 'package:f05_eshop/model/pedido.dart';
import 'package:f05_eshop/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PedidoDetail extends StatefulWidget {
  Pedido pedido;
  PedidoDetail({required this.pedido});

  @override
  State<PedidoDetail> createState() => _PedidoDetailState();
}

class _PedidoDetailState extends State<PedidoDetail> {
  late List<ItemCart> items;

  void initState() {
    super.initState();
    items = widget.pedido.produtos;
  }

  Widget _createCard(ItemCart item) {
    Product produto = item.product;
    return Card(
      child: ListTile(
        leading: Image.network(
          produto.imageUrl,
          errorBuilder: ((context, error, stackTrace) {
            return Image.network(
                'https://img.freepik.com/psd-gratuitas/presente-amarelo-com-sinal-de-icone-de-fita-dourada-ou-simbolo-ilustracao-de-fundo-3d_56104-2422.jpg?t=st=1720984225~exp=1720987825~hmac=a6e776a6a43a7a88db13b6e1ca3c61d74d24624a42fbe3c9f06da52ffac634bc&w=740');
          }),
        ),
        title: Text(produto.title),
        subtitle: Text(produto.description),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${item.quantidade}X ${produto.price.toString()} RS',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              '${(produto.price * item.quantidade).toString()} RS',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (((context, index) {
              return _createCard(items[index]);
            }))),
      ),
      drawer: MainDrawer(),
    );
  }
}
