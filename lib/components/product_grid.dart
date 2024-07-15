import 'package:f05_eshop/components/product_item.dart';
import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';
import '../model/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool _showOnlyFavoritos;
  ProductGrid(this._showOnlyFavoritos);
  @override
  Widget build(BuildContext context) {
    Future<List<Product>> produtos = ProdutoController.getProducts();

    return FutureBuilder<List<Product>>(
      future: produtos,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(
            child: Text("Ocorreu algum erro ao recuperar a lista de produtos"),
          );
        }else if(snapshot.hasData && snapshot.data!.isEmpty){
          return Center(
            child: Text("Não há produtos cadastrados!"),
          );
        }else if(snapshot.hasData){
          final List<Product> loadedProducts =
              _showOnlyFavoritos ? [] : snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: loadedProducts.length,
            itemBuilder: (context, index) {
              return ProductItem(produto: loadedProducts[index]); // Corrigido para passar 'produto'
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
