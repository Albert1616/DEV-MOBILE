import "package:mobx/mobx.dart"

part "cart.store.g.dart";

class CartModelX = _CartModelX with _$CartModelX;

abstract class _CartModelX with Store{
  double total;

  @observable
  ObservableList<ItemCart> products = ObservableList<ItemCart>();

  @computed
  ObservableList<ItemCart> get getProducts => this.products;

  @action
  void add(ItemCart itemCart){
    this.products.add(itemCart);
  }

  @action
  void remove(ItemCart itemCart){
    this.products.remove(itemCart);
  }

  @action
  void calcTotal(){
    for(ItemCart product in this.products){
      this.total += product.product.price*product.quantidade;
    }
  }
}