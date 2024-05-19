import 'package:f05_eshop/model/cart.store.dart';
import 'package:f05_eshop/model/itemCart.dart';
import 'package:f05_eshop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartModelx = Provider.of<CartModelX>(context);
    //PEGANDO CONTEUDO PELO PROVIDER
    //
    final product = Provider.of<Product>(
      context,
      listen: false,
    );

    _changeCart(String id) {
      if (product.isCartShop) {
        ItemCart? item = cartModelx.seach(id);
        if (item != null) {
          cartModelx.getProducts.remove(item);
        }
      } else {
        ItemCart item = new ItemCart(product: product, quantidade: 1);
        cartModelx.getProducts.add(item);
      }
      product.toggleCart();
    }

    //final product = context.watch<Product>();

    var isFavorite =
        context.select<Product, bool>((produto) => produto.isFavorite);

    var isCart = context.select<Product, bool>((produto) => produto.isCartShop);

    return ClipRRect(
      //corta de forma arredondada o elemento de acordo com o BorderRaius
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              //adicionando metodo ao clique do botão
              product.toggleFavorite();
            },
            //icon: Icon(Icons.favorite),
            //pegando icone se for favorito ou não
            icon: Consumer<Product>(
              builder: (context, product, child) => Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            //isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () {
                _changeCart(product.id);
              },
              icon: Consumer<Product>(
                builder: (context, product, child) => Icon(product.isCartShop
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_checkout),
              ),
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
