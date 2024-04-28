import 'package:f03_lugares/components/form_edit_place.dart';
import 'package:f03_lugares/components/main_drawer.dart';
import 'package:f03_lugares/models/myPlaces.store.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';

class ManagePlaces extends StatefulWidget {
  const ManagePlaces({super.key});

  @override
  State<ManagePlaces> createState() => _ManagePlacesState();
}

class _ManagePlacesState extends State<ManagePlaces> {
  @override
  Widget build(BuildContext context) {
    final myPlacesModelX = Provider.of<MyPlacesModelX>(context);

    _removePlace(Place place) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(
          children: [
            Text("Deseja mesmo deletar o lugar?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      setState(() {
                        myPlacesModelX.remove(place);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });
                    },
                    child: Text("Confirmar")),
                SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Text("Cancelar"))
              ],
            )
          ],
        ),
      ));
    }

    _editPlace(Place place, BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return FormEditPlace(place: place);
          });
    }

    _createPlaceCard(Place place) {
      return InkWell(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                ClipRRect(
                  //bordas na imagem
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    place.imagemUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  //só funciona no contexto do Stack - posso posicionar o elemento
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      place.titulo,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true, //quebra de lina
                      overflow: TextOverflow.fade, //case de overflow
                    ),
                  ),
                )
              ]),
              //Text(place.titulo),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              _editPlace(place, context);
                            },
                            icon: Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              _removePlace(place);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Lugares"),
      ),
      body: Observer(
          builder: (context) => Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: myPlacesModelX.getPlaces.length,
                    itemBuilder: (context, index) {
                      return _createPlaceCard(myPlacesModelX.getPlaces[index]);
                    }),
              )),
      drawer: MainDrawer(),
    );
  }
}
