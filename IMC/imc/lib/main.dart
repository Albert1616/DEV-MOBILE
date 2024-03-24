// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ImcForm());
}

class ImcForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Imc(),
    );
  }
}

class Imc extends StatefulWidget {
  @override
  State<Imc> createState() => _ImcState();
}

class _ImcState extends State<Imc> {
  final _pesoControler = TextEditingController();
  final _alturaControler = TextEditingController();

  double imc = 0;

  _calcularImc() {
    if (_pesoControler.text != '' && _alturaControler.text != '') {
      double peso = double.parse(_pesoControler.text);
      double altura = double.parse(_alturaControler.text) / 100;
      double imcValue = peso / pow(altura, 2);
      setState(() {
        imc = imcValue;
      });
      FocusScope.of(context).unfocus();
    } else {
      setState(() {
        imc = 0;
      });
    }
  }

  _mostrarStatus(double imc) {
    if (imc != 0) {
      if (imc < 18.5) {
        return Text("Abaixo do peso",
            style: TextStyle(
                backgroundColor: Colors.blue,
                fontSize: 17,
                color: Colors.white));
      } else if (imc >= 18.5 && imc < 25) {
        return Text("Peso normal",
            style: TextStyle(
                backgroundColor: Colors.green,
                fontSize: 17,
                color: Colors.white));
      } else if (imc >= 25 && imc < 30) {
        return Text("Sobrepeso",
            style: TextStyle(
                backgroundColor: Colors.yellow,
                fontSize: 17,
                color: Colors.black));
      } else if (imc >= 30 && imc < 35) {
        return Text("Obseidade grau I",
            style: TextStyle(
                backgroundColor: Color.fromARGB(255, 172, 156, 13),
                fontSize: 17,
                color: Colors.black));
      } else if (imc >= 35 && imc < 40) {
        return Text("Obseidade grau II",
            style: TextStyle(
                backgroundColor: Colors.orange,
                fontSize: 17,
                color: Colors.white));
      } else if (imc >= 40) {
        return Text("Obseidade mórbida",
            style: TextStyle(
                backgroundColor: Colors.red,
                fontSize: 17,
                color: Colors.white));
      }
    } else {
      return Text('');
    }
  }

  _mostrarIlustracao(double imc) {
    if (imc != 0) {
      if (imc < 18.5) {
        return Image.asset('images/peso_baixo.png', height: 200);
      } else if (imc >= 18.5 && imc < 25) {
        return Image.asset('images/peso_normal.png', height: 200);
      } else if (imc >= 25 && imc < 30) {
        return Image.asset('images/sobrepeso.png', height: 200);
      } else if (imc >= 30 && imc < 35) {
        return Image.asset('images/obesidade1.png', height: 200);
      } else if (imc >= 35 && imc < 40) {
        return Image.asset('images/obesidade2.png', height: 200);
      } else if (imc >= 40) {
        return Image.asset('images/obesidade3.png', height: 200);
      }
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("IMC", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.purple.shade400),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
          child: Column(
            children: [
              TextField(
                  controller: _pesoControler,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Insira seu peso",
                      labelStyle: TextStyle(fontSize: 21))),
              SizedBox(height: 15),
              TextField(
                  controller: _alturaControler,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Insira sua altura",
                      labelStyle: TextStyle(fontSize: 21))),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _calcularImc, child: Text("Calcular imc")),
              SizedBox(height: 25),
              if (imc != 0)
                Text("Seu imc é: ${imc.toStringAsPrecision(4)}",
                    style: TextStyle(fontSize: 20)),
              _mostrarStatus(imc),
              SizedBox(height: 20),
              _mostrarIlustracao(imc)
            ],
          ),
        ),
      ),
    );
  }
}
