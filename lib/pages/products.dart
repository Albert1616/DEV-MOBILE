import 'package:f05_eshop/components/form_product.dart';
import 'package:f05_eshop/components/main_drawer.dart';
import 'package:f05_eshop/controller/produto_controller.dart';
import 'package:f05_eshop/model/product.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Product>> lst_produtos;

  @override
  void initState() {
    super.initState();
    lst_produtos = ProdutoController.getProducts();
  }

  _updateScreen() {
    setState(() {
      lst_produtos = ProdutoController.getProducts();
    });
  }

  _addProduct(Product produto, String? id) {
    ProdutoController.saveProduct(produto);
    _updateScreen();
  }

  _deleteProduct(String id) {
    ProdutoController.deleteProduct(id);
    _updateScreen();
  }

  Widget _createCardProduct(BuildContext context, Product product) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 50, // Defina um tamanho fixo para a imagem
          height: 50,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons
                .error); // Ícone de erro padrão em caso de falha ao carregar a imagem
          },
        ),
        title: Text(product.title),
        subtitle: Text(product.price.toString()),
        trailing: SizedBox(
          width: 100, // Largura fixa para o widget de ação
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  _openFormModalEdit(context, product);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  _deleteProduct(product.id);
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _editProduct(Product produto, String? newId) {
    produto.id = newId!;
    ProdutoController.updateProduct(produto);
    _updateScreen();
  }

  _openFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FormProduct(onSubmit: _addProduct);
        });
  }

  _openFormModalEdit(BuildContext context, Product produto) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FormProduct(onSubmit: _editProduct, produto: produto);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<Product>>(
            future: lst_produtos,
            builder: ((context, snapshot) {
              if (snapshot.hasError ||
                  (snapshot.hasData && snapshot.data!.isEmpty)) {
                return const Center(
                  child: Text('Não há produtos cadastrados!'),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _createCardProduct(context, snapshot.data![index]);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFormModal(context);
        },
        child: Icon(Icons.add),
      ),
      drawer: MainDrawer(),
    );
  }
}
