// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:f05_eshop/components/form_product.dart';
import 'package:f05_eshop/components/main_drawer.dart';
import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:f05_eshop/model/product.dart';
import 'package:f05_eshop/model/user.store.dart';
import 'package:f05_eshop/model/user.store.dart';
import 'package:f05_eshop/pages/user_form.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../components/product_grid.dart';
import '../model/user.store.dart';
import '../utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showOnlyFavorites = false;
  @override
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Widget build(BuildContext context) {
    final userModelX = Provider.of<UserModelX>(context);

    _login(String email, String password) async {
      Navigator.of(context).pop();
      await userModelX.login(email, password)
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login efetuado com sucesso!"),
              backgroundColor: Colors.green,
            ))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Não foi encontrada nenhuma conta com esses dados"),
              backgroundColor: Colors.red,
            ));
      setState(() {});
    }

    _showDialogLogin(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: Text("Login"),
                alignment: Alignment.centerLeft,
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email"),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10),
                      Text("Password"),
                      TextField(controller: _password),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _login(_email.text, _password.text);
                              },
                              child: Text("Entrar")),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/user-form');
                              },
                              child: Text(
                                "Ainda naõ tem conta? Cadastre-se!",
                                style: TextStyle(fontSize: 10),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      );
    }

    _updateScreen(){
    setState(() {
    });
  }

    _addProduct(Product produto, String? id){
    ProdutoController.saveProduct(produto);
    _updateScreen();
  }

    _openFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FormProduct(onSubmit: _addProduct);
        });
  }

    return Scaffold(
        appBar: AppBar(
          title: Text('Minha Loja'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: Icon(Icons.shopping_cart)),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Somente Favoritos'),
                  value: FilterOptions.Favorite,
                ),
                PopupMenuItem(
                  child: Text('Todos'),
                  value: FilterOptions.All,
                ),
              ],
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorite) {
                    //provider.showFavoriteOnly();
                    _showOnlyFavorites = true;
                  } else {
                    //provider.showAll();
                    _showOnlyFavorites = false;
                  }
                });
              },
            ),
            userModelX.isLogin
                ? PopupMenuButton(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/fotos-gratis/empresario-confiante-com-barba-sorrindo-para-a-camera-gerada-por-ia_188544-33152.jpg?t=st=1720811785~exp=1720815385~hmac=1e1a2cdbe5f86a214cd12ead41c79355473665a525ebea99c23e362358b01341&w=1060'),
                      ),
                    ),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child:
                            Text('Sair', style: TextStyle(color: Colors.red)),
                        onTap: () {
                          userModelX.Logoff();
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () {
                      _showDialogLogin(context);
                    },
                    icon: Icon(Icons.person))
          ],
        ),
        body: ProductGrid(_showOnlyFavorites),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _openFormModal(context);
            },
            child: Icon(Icons.add)),
        drawer: MainDrawer());
  }
}
