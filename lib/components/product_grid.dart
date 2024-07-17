import 'package:f05_eshop/components/product_item.dart';
import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';
import '../model/product_list.dart';

class ProductGrid extends StatefulWidget {
  final bool _showOnlyFavoritos;
  ProductGrid(this._showOnlyFavoritos);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    Future<List<Product>> produtos = ProdutoController.getProducts();

    _updateScreen(){
      setState((){});
    }

    return FutureBuilder<List<Product>>(
      future: produtos,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          print(snapshot.error);
          return Center(
            child: Text("Não há produtos cadastrados!"),
          );
        }else if(snapshot.hasData && snapshot.data!.isEmpty){
          return Center(
            child: Text("Não há produtos cadastrados!"),
          );
        }else if(snapshot.hasData){
          final List<Product> loadedProducts =
              widget._showOnlyFavoritos ? [] : snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: loadedProducts.length,
            itemBuilder: (context, index) {
              return ProductItem(produto: loadedProducts[index], onSubmit: _updateScreen); // Corrigido para passar 'produto'
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 produtos por linha
              childAspectRatio: 3 / 2, // Proporção largura / altura de cada elemento
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }, 
    );
  }
}
