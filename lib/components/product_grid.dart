import 'package:f05_eshop/components/product_item.dart';
import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:f05_eshop/controller/user_controller.dart';
import 'package:f05_eshop/model/user.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
  }

  _updateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Product>> produtos = ProdutoController.getProducts();

    return FutureBuilder<List<Product>>(
      future: produtos,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text("Não há produtos para mostrar!"),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
            child: Text("Não há produtos para mostrar!"),
          );
        } else if (snapshot.hasData) {
          final List<Product> loadedProducts =
              widget._showOnlyFavoritos ? [] : snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: loadedProducts.length,
            itemBuilder: (context, index) {
              return ProductItem(
                produto: loadedProducts[index],
                onSubmit: _updateScreen,
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
