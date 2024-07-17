import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:flutter/material.dart';
import 'package:f05_eshop/model/product.dart'; // Importe o modelo Product

class FormProduct extends StatefulWidget {
  Function(Product produto, String? newId) onSubmit;
  Product? produto;
  FormProduct({required this.onSubmit,this.produto});

  @override
  _FormProductState createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void initState(){
    super.initState();
    if(widget.produto!=null){
      _titleController.text = widget.produto!.title;
      _descriptionController.text = widget.produto!.description;
      _imageUrlController.text = widget.produto!.imageUrl;
      _priceController.text = widget.produto!.price.toString();
    }
  }

  void _submitForm(BuildContext context) {
    Product newProduct = Product(
        id: 'qwe',
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
        isFavorite: false,
        isCartShop: false);
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _imageUrlController.clear();

    if(widget.produto != null){
      widget.onSubmit(newProduct, widget.produto!.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Produto atualizado com sucesso!"))
      );
    }else{
      String? newId = null;
      widget.onSubmit(newProduct,newId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto adicionado com sucesso!')),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
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
            child: widget.produto!=null? Text("Atualizar produto") : Text('Adicionar Produto'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
