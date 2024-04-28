import 'dart:ffi';

import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/myCountries.store.dart';
import 'package:f03_lugares/models/myPlaces.store.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FormEditPlace extends StatefulWidget {
  Place place;
  FormEditPlace({required this.place});

  @override
  State<FormEditPlace> createState() => _FormEditPlaceState();
}

class _FormEditPlaceState extends State<FormEditPlace> {
  final _titleController = new TextEditingController();
  final _imgUrlController = new TextEditingController();
  final _avaliacaoController = new TextEditingController();
  final _custoMedio = new TextEditingController();
  final _novaRecomendacaoController = new TextEditingController();

  void initState() {
    super.initState();
    _titleController.text = widget.place.titulo;
    _imgUrlController.text = widget.place.imagemUrl;
    _avaliacaoController.text = widget.place.avaliacao.toString();
    _custoMedio.text = widget.place.custoMedio.toString();
  }

  String DropdownValue = '';

  @override
  Widget build(BuildContext context) {
    final myCountriesModelX = Provider.of<MyCountriesModelX>(context);
    List<Country> list_countries = myCountriesModelX.getCountries;

    final myPlacesModelX = Provider.of<MyPlacesModelX>(context);

    if (DropdownValue.isEmpty) {
      DropdownValue = list_countries[0].id;
    }

    _obterCountries(List<Country> countries) {
      countries = countries
          .where((country) => widget.place.paises.contains(country.id))
          .toList();
      return countries;
    }

    _addCountry(String idCountry) {
      setState(() {
        widget.place.paises.add(idCountry);
        DropdownValue = list_countries[0].id;
      });
    }

    _removeCountry(String idCoutry) {
      setState(() {
        widget.place.paises.remove(idCoutry);
      });
    }

    _addRecommendation(String recommendation) {
      setState(() {
        widget.place.recomendacoes.add(recommendation);
        _novaRecomendacaoController.text = '';
      });
    }

    _removeRecommendation(String recommendation) {
      setState(() {
        widget.place.recomendacoes.remove(recommendation);
      });
    }

    _onChangeValue(String newValue) {
      setState(() {
        DropdownValue = newValue;
      });
    }

    _addPlace() {
      if (!_titleController.text.isEmpty) {
        widget.place.titulo = _titleController.text;
      }
      if (!_avaliacaoController.text.isEmpty) {
        widget.place.avaliacao = double.parse(_avaliacaoController.text);
      }
      if (!_custoMedio.text.isEmpty) {
        widget.place.custoMedio = double.parse(_custoMedio.text);
      }
      if (!_imgUrlController.text.isEmpty) {
        widget.place.imagemUrl = _imgUrlController.text;
      }
      myPlacesModelX.add(widget.place);
      Navigator.pop(context);
    }

    List<Country> countries_place = _obterCountries(list_countries);

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
              Text("Países"),
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
                children: widget.place.recomendacoes
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
