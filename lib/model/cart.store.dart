import "package:f05_eshop/model/itemCart.dart";
import "package:f05_eshop/model/product.dart";
import "package:mobx/mobx.dart";

part "cart.store.g.dart";

class CartModelX = _CartModelX with _$CartModelX;

abstract class _CartModelX with Store {
  double total = 0;

  @observable
  ObservableList<ItemCart> products = ObservableList<
      ItemCart>(); /* of([
    ItemCart(
      product: Product(
          id: 'p1',
          title: 'Product 1',
          description: 'Description for product 1',
          price: 30,
          imageUrl: 'https://example.com/product1.png',
          isCartShop: true),
      quantidade: 2,
    ),
    ItemCart(
      product: Product(
          id: 'p2',
          title: 'Product 2',
          description: 'Description for product 2',
          price: 50,
          imageUrl: 'https://example.com/product2.png',
          isCartShop: true),
      quantidade: 1,
    ),
  ]); */

  @computed
  ObservableList<ItemCart> get getProducts => this.products;

  @action
  void add(ItemCart itemCart) {
    this.products.add(itemCart);
  }

  @action
  void remove(ItemCart itemCart) {
    this.products.remove(itemCart);
  }

  @action
  double calcTotal() {
    this.total = 0;
    for (ItemCart product in this.products) {
      this.total += product.product.price * product.quantidade;
    }
    return this.total;
  }

  @action
  ItemCart? seach(String id) {
    try {
      return this.products.firstWhere((item) => item.product.id == id);
    } catch (e) {
      return null;
    }
  }

  @action
  void clear() {
    this.products.clear();
    this.total = 0;
  }
}
