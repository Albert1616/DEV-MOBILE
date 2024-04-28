import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:provider/provider.dart';

class formEditCountry extends StatefulWidget {
  Country country;
  formEditCountry({required this.country, super.key});

  @override
  State<formEditCountry> createState() => _formEditCountryState();
}

class _formEditCountryState extends State<formEditCountry> {
  final _titleController = new TextEditingController();

  Color colorSelected = Colors.black;

  void initState() {
    super.initState();
    _titleController.text = widget.country.title;
    colorSelected = widget.country.color;
  }

  @override
  Widget build(BuildContext context) {
    final myCountriesModelX = Provider.of<MyCountriesModelX>(context);

    _editCountry() {
      if (!_titleController.text.isEmpty) {
        widget.country.title = _titleController.text;
        widget.country.color = colorSelected;
        myCountriesModelX.add(widget.country);
        myCountriesModelX.remove(widget.country);
      }
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
                  onPressed: () => {_editCountry()},
                  child: Text("Salvar alterações"))
            ],
          ),
        ),
      ),
    );
  }
}
