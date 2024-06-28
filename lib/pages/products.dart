import 'package:f05_eshop/components/form_product.dart';
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

  _updateScreen(){
    setState(() {
      lst_produtos = ProdutoController.getProducts();
    });
  }

  _addProduct(Product produto){
    ProdutoController.saveProduct(produto);
    _updateScreen();
  }

  _deleteProduct(String id){
    ProdutoController.deleteProduct(id);
    _updateScreen();

  }

  _createCardProduct(Product product) {
    return ListTile(
      leading: Image.network(
        product.imageUrl,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.card_giftcard);
        },
      ),
      title: Text(product.title),
      subtitle: Text(product.price.toString()),
      trailing: IconButton(
        onPressed: (){_deleteProduct(product.id);},
        icon: Icon(Icons.delete),
      ),
      
    );
  }

  _openFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FormProduct(onSubmit: _addProduct);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<Product>>(
            future: lst_produtos,
            builder: ((context, snapshot) {
              if (snapshot.hasError || (snapshot.hasData && snapshot.data!.isEmpty)) {
                return const Center(
                  child: Text('Não há produtos cadastrados!'),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _createCardProduct(snapshot.data![index]);
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
    );
  }
}
