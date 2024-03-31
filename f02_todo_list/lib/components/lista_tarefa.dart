// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:f02_todo_list/pages/TarefaDetalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:intl/intl.dart';

import '../model/prioridade.dart';
import '../model/tarefa.dart';

class ListaTarefa extends StatefulWidget {
  List<Tarefa> listaTarefas;
  String filtroAtual;

  ListaTarefa({required this.listaTarefas, required this.filtroAtual});

  @override
  State<ListaTarefa> createState() => _ListaTarefaState();
}

class _ListaTarefaState extends State<ListaTarefa> {
  _corPrioridade(Prioridade priorirade) {
    switch (priorirade) {
      case Prioridade.ALTA:
        return Colors.blue.shade900;
        break;
      case Prioridade.NORMAL:
        return Colors.yellow.shade600;
        break;
      case Prioridade.BAIXA:
        return Colors.purple.shade400;
        break;
      default:
        return Colors.black;
    }
  }

  _modelDeleteTarefa(BuildContext context, String id, String titulo) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Deseja mesmo excluir a tarefa: $titulo?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _deleteTarefa(id);
                            Navigator.pop(context);
                          },
                          child: Text("Confirmar")),
                      SizedBox(width: 15),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar")),
                    ],
                  )
                ]),
          );
        });
  }

  _deleteTarefa(String id) {
    for (Tarefa tarefa in widget.listaTarefas) {
      if (tarefa.id == id) {
        setState(() {
          widget.listaTarefas.remove(tarefa);
        });
        return;
      }
    }
  }

  _filtrarPrioridade(List<Tarefa> tarefas, String prioridade) {
    if (prioridade == "nenhum") {
      return widget.listaTarefas;
    } else {
      List<Tarefa> tarefas_filtradas = [];
      for (Tarefa tarefa in tarefas) {
        if (tarefa.prioridade.toString() == prioridade) {
          tarefas_filtradas.add(tarefa);
        }
      }
      return tarefas_filtradas;
    }
  }

  _detalhesTarefa(Tarefa tarefa) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => TarefaDetalhes(tarefa: tarefa)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: widget.listaTarefas.length > 0
            ? ListView.builder(
                itemCount: widget.listaTarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = _filtrarPrioridade(
                      widget.listaTarefas, widget.filtroAtual)[index];
                  return GestureDetector(
                    onTap: (() => {_detalhesTarefa(tarefa)}),
                    child: Card(
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
                                      color: tarefa.data.day >=
                                              DateTime.now().day
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
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
                          ),
                          SizedBox(width: 20),
                          IconButton(
                              iconSize: 30,
                              onPressed: () {
                                _modelDeleteTarefa(
                                    context, tarefa.id, tarefa.titulo);
                              },
                              icon: Icon(
                                Icons.delete,
                              ))
                        ],
                      ),
                    ),
                  );
                })
            : Text("Não há tarefas cadastradas!"));
  }
}
