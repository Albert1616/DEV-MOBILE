import 'package:f03_lugares/components/form_place.dart';
import 'package:f03_lugares/components/main_drawer.dart';
import 'package:flutter/material.dart';

class AddPlace extends StatelessWidget {
  const AddPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de lugar"),
      ),
      body: FormAddPlace(),
      drawer: MainDrawer(),
    );
  }
}
