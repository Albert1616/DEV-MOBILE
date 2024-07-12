// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartModelX on _CartModelX, Store {
  Computed<ObservableList<ItemCart>>? _$getProductsComputed;

  @override
  ObservableList<ItemCart> get getProducts => (_$getProductsComputed ??=
          Computed<ObservableList<ItemCart>>(() => super.getProducts,
              name: '_CartModelX.getProducts'))
      .value;

  late final _$productsAtom =
      Atom(name: '_CartModelX.products', context: context);

  @override
  ObservableList<ItemCart> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ItemCart> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$_CartModelXActionController =
      ActionController(name: '_CartModelX', context: context);

  @override
  void add(ItemCart itemCart) {
    final _$actionInfo =
        _$_CartModelXActionController.startAction(name: '_CartModelX.add');
    try {
      return super.add(itemCart);
    } finally {
      _$_CartModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(ItemCart itemCart) {
    final _$actionInfo =
        _$_CartModelXActionController.startAction(name: '_CartModelX.remove');
    try {
      return super.remove(itemCart);
    } finally {
      _$_CartModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  double calcTotal() {
    final _$actionInfo = _$_CartModelXActionController.startAction(
        name: '_CartModelX.calcTotal');
    try {
      return super.calcTotal();
    } finally {
      _$_CartModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  ItemCart? seach(String id) {
    final _$actionInfo =
        _$_CartModelXActionController.startAction(name: '_CartModelX.seach');
    try {
      return super.seach(id);
    } finally {
      _$_CartModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
getProducts: ${getProducts}
    ''';
  }
}
