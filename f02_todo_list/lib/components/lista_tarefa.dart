// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:intl/intl.dart';

import '../model/prioridade.dart';
import '../model/tarefa.dart';

class ListaTarefa extends StatelessWidget {
  List<Tarefa> listaTarefas;

  ListaTarefa({
    required this.listaTarefas,
  });
  _corPrioridade(Prioridade priorirade) {
    switch (priorirade) {
      case Prioridade.ALTA:
        return Colors.blue.shade900;
        break;
      case Prioridade.NORMAL:
        return Colors.yellow.shade900;
        break;
      case Prioridade.BAIXA:
        return Colors.purple.shade400;
        break;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: listaTarefas.length > 0
            ? ListView.builder(
                itemCount: listaTarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = listaTarefas[index];
                  return Card(
                    color: tarefa.data.isAfter(DateTime.now())
                        ? Colors.green.shade300
                        : Colors.red.shade300,
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: tarefa.data.day >= DateTime.now().day
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(
                                DateFormat('d MMM y').format(tarefa.data),
                                style: TextStyle(
                                    color: tarefa.data.day >= DateTime.now().day
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tarefa.titulo),
                            Text(
                              "Prioridade: ${tarefa.prioridade.toString().split(".").last}",
                              style: TextStyle(
                                  color: _corPrioridade(tarefa.prioridade)),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })
            : Text("Não há tarefas cadastradas!"));
  }
}
