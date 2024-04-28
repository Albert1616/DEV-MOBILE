import 'package:flutter/material.dart';

class Country {
  final String id;
  String title;
  Color color;

  Country({
    required this.id,
    required this.title,
    this.color = Colors.blue,
  });
}
