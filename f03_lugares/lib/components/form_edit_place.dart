import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:flutter/material.dart';

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

  List<String> countries = [];
  List<String> recomendacoes = [];
  List<Country> countries_selected = [];
  List<bool> _checks = [];

  void initState() {
    super.initState();
    _titleController.text = widget.place.titulo;
    _imgUrlController.text = widget.place.imagemUrl;
    _avaliacaoController.text = widget.place.avaliacao.toString();
    _custoMedio.text = widget.place.custoMedio.toString();
    countries = widget.place.paises;
    recomendacoes = widget.place.recomendacoes;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Nome do lugar"),
              ),
              TextField(
                controller: _imgUrlController,
                decoration: InputDecoration(labelText: "URL da imagem: "),
              ),
              TextField(
                controller: _avaliacaoController,
                decoration: InputDecoration(labelText: "Avalicação: "),
              ),
              TextField(
                controller: _custoMedio,
                decoration: InputDecoration(labelText: "Custo médio: "),
              ),
              Text("Países"),
              Row(
                  children: countries.map((country) {
                return Text(country);
              }).toList()),
              Text("Recomendações"),
              Row(
                  children: recomendacoes.map((recomendacao) {
                return Text(recomendacao);
              }).toList()),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Adicionar lugar"))
            ],
          ),
        ),
      ),
    );
  }
}
