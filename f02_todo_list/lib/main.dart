import 'dart:math';
import 'package:flutter/material.dart';
import 'components/form_tarefa.dart';
import 'components/lista_tarefa.dart';
import 'model/prioridade.dart';
import 'model/tarefa.dart';

void main() {
  runApp(ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.amber,
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tarefa> _tarefas = [
    Tarefa(
        id: 't0',
        titulo: 'Estudar',
        descricao: "descricao",
        comentarios: "comentarios",
        prioridade: Prioridade.ALTA,
        data: DateTime.now()),
    Tarefa(
        id: 't1',
        titulo: 'Jogar',
        descricao: "descricao",
        comentarios: "comentarios",
        prioridade: Prioridade.ALTA,
        data: DateTime.now()),
    Tarefa(
        id: 't1',
        titulo: 'Jogar',
        descricao: "descricao",
        comentarios: "comentarios",
        prioridade: Prioridade.ALTA,
        data: DateTime.now()),
    Tarefa(
        id: 't1',
        titulo: 'Jogar',
        descricao: "descricao",
        comentarios: "comentarios",
        prioridade: Prioridade.ALTA,
        data: DateTime.now()),
  ];
  _novaTarefa(String titulo, String descricao, String comentarios,
      Prioridade prioridade, DateTime data) {
    Tarefa novaTarefa = Tarefa(
      id: Random().nextInt(9999).toString(),
      titulo: titulo,
      data: data,
      comentarios: comentarios,
      descricao: descricao,
      prioridade: prioridade,
    );
    setState(() {
      _tarefas.add(novaTarefa);
    });

    Navigator.of(context).pop();
  }

  _updateList(List<Tarefa> tarefas_update) {
    setState(() {
      this._tarefas = tarefas_update;
    });
  }

  //Modal
  _openTaskFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return FormTarefa(_novaTarefa);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        actions: [
          IconButton(
              onPressed: () => _openTaskFormModal(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            // formulario de tarefa

            //FormTarefa(_novaTarefa),
            const SizedBox(
              height: 20,
            ),
            // lista de tarefas
            ListaTarefa(listaTarefas: _tarefas, onUpdate: _updateList),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
