import 'package:f05_eshop/model/product.dart';
import 'package:flutter/material.dart';
import 'package:f05_eshop/components/product_item.dart';
import 'package:provider/provider.dart';
import '../model/user.store.dart';

class FavoritosPage extends StatefulWidget {
  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {

  _createCardProduct(BuildContext context, Product product) {
  return Card(
    child: ListTile(
      leading: Image.network(
        product.imageUrl,
        width: 50,  // Defina um tamanho fixo para a imagem
        height: 50,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);  // Ícone de erro padrão em caso de falha ao carregar a imagem
        },
      ),
      title: Text(product.title),
      subtitle: Text(product.price.toString()),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final userModelX = Provider.of<UserModelX>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Favoritos'),
      ),
      body: FutureBuilder(
        future: userModelX.loadFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (userModelX.isLogin && userModelX.favoritos.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: userModelX.favoritos.length,
                itemBuilder: (context, index) {
                  return _createCardProduct(context, userModelX.favoritos[index]);
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
                child: Text('Nenhum produto favorito encontrado.'),
              );
            }
          }
        },
      ),
    );
  }
}
