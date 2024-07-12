import 'dart:math';

class User{
  String id = Random().nextInt(100).toString();
  String name;
  String email;
  String password;

  User({required this.name,required this.email, required this.password});
}