import 'package:f03_lugares/components/place_item.dart';
import 'package:f03_lugares/models/favorites.store.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteModelX = Provider.of<FavoritesModelX>(context);
    if (favoriteModelX.getPlaces.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum Lugar Marcado como Favorito!',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return Observer(
        builder: (context) => ListView.builder(
            itemCount: favoriteModelX.getPlaces.length,
            itemBuilder: (ctx, index) {
              return PlaceItem(favoriteModelX.getPlaces[index]);
            }),
      );
    }
  }
}
