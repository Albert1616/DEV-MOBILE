import 'package:f03_lugares/components/country_item.dart';
import 'package:f03_lugares/components/main_drawer.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/my_data.dart';

class CountriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myCountriesModelX = Provider.of<MyCountriesModelX>(context);
    return Scaffold(
      /*  appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Bora viajar?!',
          )), */
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent:
              200, //cada elemento com extenso maxima de 200 pixel
          childAspectRatio: 3 / 2, //proporcao de cada elemento dentro do grid
          crossAxisSpacing: 20, //espacamento no eixo cruzado
          mainAxisSpacing: 20, //espacamento no eixo principal
        ),
        children: myCountriesModelX.getCountries.map((country) {
          return CountryItem(country);
        }).toList(),
      ),
    );
  }
}
