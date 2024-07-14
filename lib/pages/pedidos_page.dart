import 'package:f05_eshop/components/main_drawer.dart';
import 'package:f05_eshop/controller/user_controller.dart';
import 'package:f05_eshop/model/pedido.dart';
import 'package:f05_eshop/model/user.store.dart';
import 'package:f05_eshop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  @override
  Widget build(BuildContext context) {
    final _email = new TextEditingController();
    final _password = new TextEditingController();

    final userModelX = Provider.of<UserModelX>(context);
    late Future<List<Pedido>> pedidos;

    if (userModelX.isLogin) {
      pedidos = UserController.getPedidos(userModelX.currentUser!.id);
    }

    _login(String email, String password) async {
      Navigator.of(context).pop();
      await userModelX.login(email, password)
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login efetuado com sucesso!"),
              backgroundColor: Colors.green,
            ))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Não foi encontrada nenhuma conta com esses dados"),
              backgroundColor: Colors.red,
            ));
      setState(() {});
    }

    _showDialogLogin(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: Text("Login"),
                alignment: Alignment.centerLeft,
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email"),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10),
                      Text("Password"),
                      TextField(controller: _password),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _login(_email.text, _password.text);
                              },
                              child: Text("Entrar")),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/user-form');
                              },
                              child: Text(
                                "Ainda naõ tem conta? Cadastre-se!",
                                style: TextStyle(fontSize: 10),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      );
    }

    _createCard(Pedido pedido, int index) {
      return ListTile(
        leading: Icon(Icons.card_giftcard),
        title: Text('Pedido $index'),
        subtitle: Text(pedido.data.toString().substring(0, 10)),
        trailing: Text('${pedido.total.toString()} RS'),
        onTap: () {},
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Pedidos'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: Icon(Icons.shopping_cart)),
            userModelX.isLogin
                ? PopupMenuButton(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/fotos-gratis/empresario-confiante-com-barba-sorrindo-para-a-camera-gerada-por-ia_188544-33152.jpg?t=st=1720811785~exp=1720815385~hmac=1e1a2cdbe5f86a214cd12ead41c79355473665a525ebea99c23e362358b01341&w=1060'),
                      ),
                    ),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child:
                            Text('Sair', style: TextStyle(color: Colors.red)),
                        onTap: () {
                          userModelX.Logoff();
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () {
                      _showDialogLogin(context);
                    },
                    icon: Icon(Icons.person))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: userModelX.isLogin
                ? FutureBuilder<List<Pedido>>(
                    future: pedidos,
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text("Você ainda não fez nenhum pedido!"),
                        );
                      } else if (snapshot.hasData) {
                        print("Tem pedidos!");
                        print(userModelX.currentUser!.id);
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return _createCard(
                                snapshot.data![index], index + 1);
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "É necessário estar logado para gerenciar seus pedidos"),
                      ElevatedButton(
                        onPressed: () {
                          _showDialogLogin(context);
                        },
                        child: Text("Faça seu login agora!"),
                      )
                    ],
                  ))),
        drawer: MainDrawer());
  }
}
