import 'dart:convert';

import 'package:f05_eshop/model/user.dart';
import 'package:http/http.dart' as http;

class UserController{
  UserController();

  static String url = 'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/user.json';

  static Future<List<User>> getUsers() async{
    final response = await http.get(Uri.parse(url));

    final List<User> users = [];

    if(response.statusCode == 200){
      final Map<String,dynamic> jbody = jsonDecode(response.body);
      jbody.forEach((key,value){
        User user = new User(
          name: value['name'], email: value['email'], 
          password: value['password']);

        users.add(user);
      });

      if(users.isEmpty){
        throw new Exception("Não há usuários cadastrados!");
      }
      return users;
    }

    throw new Exception("Não foi possível retornar a lista de usuários!");
  }

  static Future<bool> existUser(String email, String password) async{
    print("procurando....");
    final List<User> users = await getUsers();
    bool userExits = users.any((user) => user.email == email && user.password == password);
    return userExits;
  }

  static Future<bool> saveUser(User user) async{
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'name':user.name,
        'email':user.email,
        'password':user.password
      })
    );

    if(response.statusCode == 200){
      return true;
    }

    throw new Exception("ERRO: Não foi possível salvar o usuário!");
  }
}