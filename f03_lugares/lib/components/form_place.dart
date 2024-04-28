import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:f03_lugares/models/myPlaces.store.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:f03_lugares/screens/add_place.dart';
import 'package:f03_lugares/screens/manage_places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FormAddPlace extends StatefulWidget {
  @override
  State<FormAddPlace> createState() => _FormAddPlaceState();
}

class _FormAddPlaceState extends State<FormAddPlace> {
  final _titleController = new TextEditingController();
  final _imgUrlController = new TextEditingController();
  final _avaliacaoController = new TextEditingController();
  final _custoMedio = new TextEditingController();
  final _novaRecomendacaoController = new TextEditingController();

  List<String> countries = [];
  List<String> recommedactions = [];
  String DropdownValue = '';

  @override
  Widget build(BuildContext context) {
    final myCountriesModelX = Provider.of<MyCountriesModelX>(context);
    List<Country> list_countries = myCountriesModelX.getCountries;

    final myPlacesModelX = Provider.of<MyPlacesModelX>(context);

    if (DropdownValue.isEmpty) {
      DropdownValue = list_countries[0].id;
    }

    _addCountry(String idCountry) {
      setState(() {
        countries.add(idCountry);
        DropdownValue = list_countries[0].id;
      });
    }

    _removeCountry(String idCoutry) {
      setState(() {
        countries.remove(idCoutry);
      });
    }

    _addRecommendation(String recommendation) {
      setState(() {
        recommedactions.add(recommendation);
        _novaRecomendacaoController.text = '';
      });
    }

    _removeRecommendation(String recommendation) {
      setState(() {
        recommedactions.remove(recommendation);
      });
    }

    _obterCountries(List<Country> lst_countries) {
      lst_countries = lst_countries
          .where((country) => countries.contains(country.id))
          .toList();
      return lst_countries;
    }

    _onChangeValue(String newValue) {
      setState(() {
        DropdownValue = newValue;
      });
    }

    List<Country> countries_place = _obterCountries(list_countries);

    _addPlace() {
      if (!_titleController.text.isEmpty &&
          !_avaliacaoController.text.isEmpty &&
          !_custoMedio.text.isEmpty &&
          !_imgUrlController.text.isEmpty &&
          !countries.isEmpty) {
        int index = myPlacesModelX.getPlaces.length + 2;
        Place place = new Place(
            id: 'p' + index.toString(),
            paises: countries,
            titulo: _titleController.text,
            imagemUrl: _imgUrlController.text,
            recomendacoes: recommedactions,
            avaliacao: double.parse(_avaliacaoController.text),
            custoMedio: double.parse(_custoMedio.text));
        myPlacesModelX.add(place);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Lugar adicionado com sucesso!",
                style: TextStyle(color: Colors.red.shade600))));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ManagePlaces(),
          ),
        );
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Preencha todos os campos!",
                style: TextStyle(color: Colors.red.shade600))));
      }
    }

    return SingleChildScrollView(
      reverse: true,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,

              // chage 2
              left: 10,
              right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Nome do lugar"),
              ),
              TextField(
                maxLines: null,
                controller: _imgUrlController,
                decoration: InputDecoration(labelText: "URL da imagem: "),
              ),
              TextField(
                controller: _avaliacaoController,
                decoration: InputDecoration(labelText: "Avalicação: "),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _custoMedio,
                decoration: InputDecoration(labelText: "Custo médio: "),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 10),
              Text("Países - adicione os países do lugar"),
              Column(
                children: countries_place
                    .map((country) => ListTile(
                          leading: Icon(Icons.map_rounded),
                          title: Text(country.title,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _removeCountry(country.id);
                            },
                          ),
                        ))
                    .toList(),
              ),
              Row(children: [
                DropdownButton<String>(
                    value: DropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: Container(
                      height: 1,
                      color: Colors.blueGrey,
                    ),
                    onChanged: (String? newValue) =>
                        {_onChangeValue(newValue!)},
                    items: list_countries
                        .map((Country country) => DropdownMenuItem<String>(
                              value: country.id,
                              child: Text(country.title),
                            ))
                        .toList()),
                IconButton(
                    onPressed: () {
                      _addCountry(DropdownValue);
                    },
                    icon: Icon(Icons.add))
              ]),
              SizedBox(height: 10),
              Text("Recomendações "),
              Column(
                children: recommedactions
                    .map((recomedacao) => ListTile(
                          leading: Icon(Icons.check_circle),
                          title: Text(recomedacao,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _removeRecommendation(recomedacao);
                            },
                          ),
                        ))
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _novaRecomendacaoController,
                      decoration:
                          InputDecoration(labelText: "Nova recomendação..."),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _addRecommendation(_novaRecomendacaoController.text);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _addPlace();
                  },
                  child: Text("Adicionar lugar"))
            ],
          ),
        ),
      ),
    );
  }
}
