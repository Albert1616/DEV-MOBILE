class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  _createCard(ItemCart item){
    return ListTile(
      leading: const Icon(Icons.product),
      title: const Text(
      item.product.title,
      textScaleFactor: 1.5,
    ),
    trailing: const Row(
      children:[
        Text(item.quantidade),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed:(){}
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed:(){}
        )
      ]
    )
    ),
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Padding(
        child:Column(
          children:[
            
          ]
        )
      )
    )
  }
}