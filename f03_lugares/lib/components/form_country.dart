import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:provider/provider.dart';

class formCountry extends StatefulWidget {
  const formCountry({super.key});

  @override
  State<formCountry> createState() => _formCountryState();
}

class _formCountryState extends State<formCountry> {
  final _titleController = new TextEditingController();

  Color colorSelected = Colors.black;

  @override
  Widget build(BuildContext context) {
    final myCountriesModelX = Provider.of<MyCountriesModelX>(context);

    _addCountry() {
      int id = myCountriesModelX.getCountries.length + 2;
      Country country = new Country(
          id: "c" + id.toString(),
          title: _titleController.text,
          color: colorSelected);
      myCountriesModelX.add(country);
      Navigator.pop(context);
    }

    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Nome do país")),
              SizedBox(height: 10),
              Text("Cor: ", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              ColorPicker(
                  color: colorSelected,
                  onChanged: (value) => {colorSelected = value}),
              ElevatedButton(
                  onPressed: () => _addCountry(), child: Text("Adicionar País"))
            ],
          ),
        ),
      ),
    );
  }
}
