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

  final _baseURL =
      'https://mini-projeto-iv---flutter-default-rtdb.firebaseio.com/';

  @override
  void initState() {
    super.initState();
    lst_produtos = ProdutoController.getProducts();
  }

  _createCardProduct(Product product) {
    return ListTile(
      leading: Image.network(product.imageUrl),
      title: Text(product.title),
      trailing: Text(product.price.toString()),
    );
  }

  _openFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FormProduct();
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
              if (snapshot.hasError) {
                return const Center(
                  child: Text('ERRO'),
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
