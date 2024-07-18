import 'package:f05_eshop/controller/user_controller.dart';
import 'package:f05_eshop/model/product.dart';
import 'package:f05_eshop/model/user.dart';
import 'package:mobx/mobx.dart';

part 'user.store.g.dart';

class UserModelX = _UserModelx with _$UserModelX;

abstract class _UserModelx with Store {
  @observable
  bool isLogin = false;

  @observable
  User? currentUser;

  @observable
  ObservableList<Product> favoritos = ObservableList<Product>();

  @computed
  bool get getIsLogin => this.isLogin;

  @action
  Future<bool> login(String email, String password) async {
    User user = await UserController.existUser(email, password);
    if (user != null) {
      isLogin = true;
      currentUser = user;
      return true;
    }
    return false;
  }

  @action
  void Logoff() {
    this.isLogin = false;
    currentUser = null;
  }

  @action
  Future<void> loadFavorites() async{
    if (currentUser != null) {
      String id = currentUser!.id;
      List<Product> favorites = await UserController.getFavorites(id);
      favoritos.clear();
      favoritos.addAll(favorites);
    }
  }
}
