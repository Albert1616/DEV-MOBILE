// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:f05_eshop/controller/user_controller.dart';
import 'package:f05_eshop/model/cart.store.dart';
import 'package:f05_eshop/model/itemCart.dart';
import 'package:f05_eshop/model/user.store.dart';
import 'package:f05_eshop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductItem extends StatefulWidget {
  Product produto;
  Function() onSubmit;
  ProductItem({required this.produto, required this.onSubmit});
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.produto.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final cartModelx = Provider.of<CartModelX>(context);
    final userModelX = Provider.of<UserModelX>(context);

    _updateScreen() {
      setState(() {});
    }

    _changeCart(String id) {
      if (widget.produto.isCartShop) {
        ItemCart? item = cartModelx.seach(id);
        if (item != null) {
          cartModelx.getProducts.remove(item);
        }
      } else {
        ItemCart item = new ItemCart(product: widget.produto, quantidade: 1);
        cartModelx.getProducts.add(item);
      }
      widget.produto.toggleCart();
    }

    _toggleFavoriteItems(Product produto) async {
      if (userModelX.currentUser != null) {
        String id = userModelX.currentUser!.id;
        if (await UserController.isFavorite(id, produto.title)) {
          UserController.removeToFavorites(id, produto);
          setState(() {
            isFavorite = false;
          });
        } else {
          UserController.addToFavorites(id, produto);
          setState(() {
            isFavorite = true;
          });
        }
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Você precisa estar logado para favoritar produtos!",
          ),
          backgroundColor: Colors.red,
        ));
      }
      _updateScreen();
      widget.onSubmit();
    }

    return ClipRRect(
      //corta de forma arredondada o elemento de acordo com o BorderRaius
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            widget.produto.imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                  'https://img.freepik.com/fotos-gratis/caixa-de-presente-de-renderizacao-3d-com-pacote-de-presente-de-fita_107791-17997.jpg?t=st=1721141100~exp=1721144700~hmac=f7750b61afba8d1f8664ccb678cec362426dc8a32179f3d1c6c4c1aebd08a798&w=740');
            },
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: widget.produto);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              setState(() {
                _toggleFavoriteItems(widget.produto);
              });
            },
            icon: Icon((isFavorite && userModelX.currentUser != null)
                ? Icons.favorite
                : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            widget.produto.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  _changeCart(widget.produto.id);
                });
              },
              icon: Icon(widget.produto.isCartShop
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_checkout),
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
