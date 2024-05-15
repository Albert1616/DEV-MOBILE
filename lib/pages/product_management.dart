class Product_Management extends StatelessWidget {
  const Product_Management({super.key});

  @override
  Widget build(BuildContext context) {

    _openForm(BuildContext context){                                       
      Navigator.of(context).pushNamed(
        AppRoutes.PRODUCT_FORM
      );
    }
    final provider = Provider.of<ProductList>(context);
    List<Product> products = provider.
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [],
      ),
      body: ListView.builder(
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: loadedProducts[i],
          child: ProductItem(),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _openForm(context)),
        child: Icon(Icons.add),
      ),
    );
  }
}