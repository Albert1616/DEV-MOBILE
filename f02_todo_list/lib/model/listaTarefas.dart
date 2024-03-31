import 'package:flutter/material.dart';

import 'prioridade.dart';
import 'tarefa.dart';

class listaTarefas extends ChangeNotifier {
  List<Tarefa> tarefas = [
    Tarefa(
        id: 't0',
        titulo: 'Estudar',
        descricao: "descricao",
        prioridade: Prioridade.ALTA,
        data: DateTime.now()),
    Tarefa(
        id: 't1',
        titulo: 'Jogar',
        descricao: "descricao",
        prioridade: Prioridade.ALTA,
        data: DateTime.now()),
  ];
  _deleteTarefa(String id) {
    for (Tarefa tarefa in tarefas) {
      if (tarefa.id == id) {
        tarefas.remove(tarefa);
        notifyListeners();
      }
    }
  }
}
