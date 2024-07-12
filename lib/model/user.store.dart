import 'package:f05_eshop/controller/user_controller.dart';
import 'package:f05_eshop/model/user.dart';
import 'package:mobx/mobx.dart';

part 'user.store.g.dart';

class UserModelX = _UserModelx with _$UserModelX;

abstract class _UserModelx with Store{
  @observable
  bool isLogin = false;

  @computed
  bool get getIsLogin => this.isLogin;

  @action
  Future<bool> login(String email, String password) async{
    bool existUser = await UserController.existUser(email, password);
    if(existUser){
      isLogin = true;
    }
    return existUser;
  }

  @action
  void Logoff(){
    this.isLogin = false;
  }
}