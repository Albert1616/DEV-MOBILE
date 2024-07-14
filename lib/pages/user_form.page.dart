import 'dart:math';

import 'package:f05_eshop/controller/user_controller.dart';
import 'package:f05_eshop/model/user.dart';
import 'package:f05_eshop/pages/products_overview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserFormPage extends StatelessWidget {
  UserFormPage();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    String id = ('a${Random().nextInt(9999)}');
    // Criar uma instância de User com os dados do formulário
    User newUser = User(
        id: id,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        pedidos: []);

    UserController.saveUser(newUser);

    // Exemplo de feedback ao usuário após a submissão
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuário adicionado com sucesso!')),
    );

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductsOverviewPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criar conta'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back))
          ],
        ),
        body: Column(
          children: [
            TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome')),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _submitForm(context);
              },
              child: Text('Criar conta'),
            ),
          ],
        ));
  }
}
