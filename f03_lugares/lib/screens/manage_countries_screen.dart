import 'package:f03_lugares/components/form_country.dart';
import 'package:f03_lugares/components/main_drawer.dart';
import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ManageCountries extends StatefulWidget {
  const ManageCountries({super.key});

  @override
  State<ManageCountries> createState() => _ManageCountriesState();
}

class _ManageCountriesState extends State<ManageCountries> {
  _openFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return formCountry();
        });
  }

  @override
  Widget build(BuildContext context) {
    final myCountriesModelX = Provider.of<MyCountriesModelX>(context);
    _removeCountry(Country country) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(
          children: [
            Text("Deseja mesmo deletar o país?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      setState(() {
                        myCountriesModelX.remove(country);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });
                    },
                    child: Text("Confirmar")),
                SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Text("Cancelar"))
              ],
            )
          ],
        ),
      ));
    }

    _createCountryCard(Country country) {
      return Card(
        color: country.color,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                country.title,
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  IconButton(onPressed: () => {}, icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () => {_removeCountry(country)},
                      icon: Icon(Icons.delete))
                ],
              )
            ],
          ),
        ),
      );
    }

    final List<Country> countries = myCountriesModelX.getCountries;
    return Scaffold(
      appBar: AppBar(
        title: Text("Países"),
      ),
      body: Observer(
          builder: (context) => Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: myCountriesModelX.getCountries.length,
                    itemBuilder: (context, index) {
                      return _createCountryCard(
                          myCountriesModelX.getCountries[index]);
                    }),
              )),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _openFormModal(context)),
        child: Icon(Icons.add),
      ),
    );
  }
}
