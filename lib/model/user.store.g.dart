// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserModelX on _UserModelx, Store {
  Computed<bool>? _$getIsLoginComputed;

  @override
  bool get getIsLogin =>
      (_$getIsLoginComputed ??= Computed<bool>(() => super.getIsLogin,
              name: '_UserModelx.getIsLogin'))
          .value;

  late final _$isLoginAtom =
      Atom(name: '_UserModelx.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_UserModelx.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$favoritosAtom =
      Atom(name: '_UserModelx.favoritos', context: context);

  @override
  ObservableList<Product> get favoritos {
    _$favoritosAtom.reportRead();
    return super.favoritos;
  }

  @override
  set favoritos(ObservableList<Product> value) {
    _$favoritosAtom.reportWrite(value, super.favoritos, () {
      super.favoritos = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_UserModelx.login', context: context);

  @override
  Future<bool> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$loadFavoritesAsyncAction =
      AsyncAction('_UserModelx.loadFavorites', context: context);

  @override
  Future<void> loadFavorites() {
    return _$loadFavoritesAsyncAction.run(() => super.loadFavorites());
  }

  late final _$_UserModelxActionController =
      ActionController(name: '_UserModelx', context: context);

  @override
  void Logoff() {
    final _$actionInfo =
        _$_UserModelxActionController.startAction(name: '_UserModelx.Logoff');
    try {
      return super.Logoff();
    } finally {
      _$_UserModelxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
currentUser: ${currentUser},
favoritos: ${favoritos},
getIsLogin: ${getIsLogin}
    ''';
  }
}
