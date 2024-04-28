import 'dart:ui';

import 'package:f03_lugares/models/favorites.store.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:f03_lugares/models/myPlaces.store.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:f03_lugares/screens/add_place.dart';
import 'package:f03_lugares/screens/countries_places_screen.dart';
import 'package:f03_lugares/screens/manage_countries_screen.dart';
import 'package:f03_lugares/screens/manage_places_screen.dart';
import 'package:f03_lugares/screens/place_detail_screen.dart';
import 'package:f03_lugares/screens/settings_screen.dart';
import 'package:f03_lugares/screens/tabs_screen.dart';
import 'package:f03_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/countries_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FavoritesModelX>(create: (context) => FavoritesModelX()),
          Provider<MyCountriesModelX>(create: (context) => MyCountriesModelX()),
          Provider<MyPlacesModelX>(create: (context) => MyPlacesModelX())
        ],
        child: MaterialApp(
          title: 'PlacesToGo',
          theme: ThemeData(
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(primary: Colors.purple, secondary: Colors.amber),
            fontFamily: 'Raleway',
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                  ),
                ),
          ),
          //home: CountriesScreen(),
          initialRoute: '/',
          routes: {
            AppRoutes.HOME: (ctx) => TabsScreen(),
            AppRoutes.COUNTRY_PLACES: (ctx) => CountryPlacesScreen(),
            AppRoutes.PLACES_DETAIL: (ctx) => PlaceDetailScreen(),
            AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
            AppRoutes.ADD_PLACE: (ctx) => AddPlace(),
            AppRoutes.COUNTRIES: (ctx) => ManageCountries(),
            AppRoutes.PLACES: (ctx) => ManagePlaces()
          },
        ));
  }
}
