import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:flutter/material.dart';
import 'package:f05_eshop/model/product.dart'; // Importe o modelo Product

class FormProduct extends StatefulWidget {
  const FormProduct({super.key});

  @override
  _FormProductState createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _submitForm(BuildContext context) {
    // Criar uma instância de Product com os dados do formulário
    Product newProduct = Product(
        id: 'qwe', // Exemplo de ID baseado no tempo
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
        isFavorite: true,
        isCartShop: true);
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _imageUrlController.clear();

    ProdutoController.saveProduct(newProduct);

    // Exemplo de feedback ao usuário após a submissão
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Produto adicionado com sucesso!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: 'Título'),
        ),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Descrição'),
        ),
        TextField(
          controller: _priceController,
          decoration: InputDecoration(labelText: 'Preço'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        TextField(
          controller: _imageUrlController,
          decoration: InputDecoration(labelText: 'URL da Imagem'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _submitForm(context);
          },
          child: Text('Adicionar Produto'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Limpar os controladores quando o widget for descartado
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
