import 'package:f03_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget _createItem(IconData icon, String label, Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(40),
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.bottomRight,
            child: Text(
              'Vamos viajar?',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          _createItem(Icons.home, 'Home',
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)),
          _createItem(
              Icons.settings,
              'Configurações',
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.SETTINGS)),
          _createItem(
              Icons.place,
              'Adicionar lugar',
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.FORM_PLACE)),
          _createItem(
              Icons.map,
              'Países',
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.COUNTRIES)),
          _createItem(
              Icons.place_sharp,
              'Lugares',
              () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.PLACES)),
        ],
      ),
    );
  }
}
