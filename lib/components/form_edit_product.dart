import 'package:f05_eshop/model/product.dart';
import 'package:flutter/cupertino.dart';

class FormEditProduct extends StatefulWidget {
  Product produto;
  FormEditProduct({required this.produto});

  @override
  State<FormEditProduct> createState() => _FormEditProductState();
}

class _FormEditProductState extends State<FormEditProduct> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
