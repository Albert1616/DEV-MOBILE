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
  Function(List<Tarefa>) onUpdate;

  ListaTarefa({required this.listaTarefas, required this.onUpdate});

  @override
  State<ListaTarefa> createState() => _ListaTarefaState();
}

class _ListaTarefaState extends State<ListaTarefa> {
  String _prioridadeSelecionada = "Nenhuma";
  String _filtro = "Nenhuma";
  DateTime _dataSelecionada = DateTime.now();
  DateTime _dataCricaoSelecionada = DateTime.now();

  void initialState() {
    super.initState();
  }

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
                    child: Text("Confirmar"),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _deleteTarefa(String id) {
    Tarefa tarefa_remove = widget.listaTarefas[0];
    for (Tarefa tarefa in widget.listaTarefas) {
      if (tarefa.id == id) {
        tarefa_remove = tarefa;
      }
    }
    List<Tarefa> tarefas_update = widget.listaTarefas;
    tarefas_update.remove(tarefa_remove);
    widget.onUpdate(tarefas_update);
  }

  _updateTarefa(Tarefa tarefa) {
    int index =
        widget.listaTarefas.indexWhere((element) => element.id == tarefa.id);
    if (index != -1) {
      widget.listaTarefas[index] = tarefa;
    }
    widget.onUpdate(widget.listaTarefas);
  }

  _filtrarPrioridade(String tipo, String prioridade) {
    List<Tarefa> tarefas_filtradas = [];
    switch (tipo) {
      case "Prioridade":
        tarefas_filtradas = [];
        if (prioridade == "Nenhuma") {
          return widget.listaTarefas;
        } else {
          for (Tarefa tarefa in widget.listaTarefas) {
            if (tarefa.prioridade.toString().split(".").last == prioridade) {
              tarefas_filtradas.add(tarefa);
            }
          }
        }
        break;
      case "data":
        tarefas_filtradas = [];
        for (Tarefa tarefa in widget.listaTarefas) {
          if (tarefa.data.year == _dataSelecionada.year &&
              tarefa.data.month == _dataSelecionada.month &&
              tarefa.data.day == _dataSelecionada.day) {
            tarefas_filtradas.add(tarefa);
          }
        }
        break;
      case "dataCriacao":
        tarefas_filtradas = [];
        for (Tarefa tarefa in widget.listaTarefas) {
          if (tarefa.data.year == _dataCricaoSelecionada.year &&
              tarefa.data.month == _dataCricaoSelecionada.month &&
              tarefa.data.day == _dataCricaoSelecionada.day) {
            tarefas_filtradas.add(tarefa);
          }
        }
        break;
      case "Nenhuma":
        tarefas_filtradas = widget.listaTarefas;
    }
    return tarefas_filtradas.isNotEmpty ? tarefas_filtradas : [];
  }

  _showDatePicker(String dataTipo) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      if (dataTipo == "dataExecucao") {
        setState(() {
          _dataSelecionada = pickedDate;
          _filtro = "data";
        });
        _filtrarPrioridade("data", _dataSelecionada.toString());
      } else if (dataTipo == "dataCriacao") {
        setState(() {
          _dataCricaoSelecionada = pickedDate;
          _filtro = "dataCriacao";
        });
      }
    });
  }

  _detalhesTarefa(Tarefa tarefa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TarefaDetalhes(
          tarefa: tarefa,
          onDelete: _deleteTarefa,
          onUpdate: _updateTarefa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Filtrar por prioridade: "),
              DropdownButton<String>(
                value: _prioridadeSelecionada,
                items: [
                  DropdownMenuItem(
                    child: Text("Nenhuma"),
                    value: "Nenhuma",
                    onTap: () => {_filtrarPrioridade("Prioridade", "Nenhuma")},
                  ),
                  DropdownMenuItem(
                    child: Text("BAIXA"),
                    value: "BAIXA",
                    onTap: () => {_filtrarPrioridade("Prioridade", "BAIXA")},
                  ),
                  DropdownMenuItem(
                    child: Text("NORMAL"),
                    value: "NORMAL",
                    onTap: () => {_filtrarPrioridade("Prioridade", "NORMAL")},
                  ),
                  DropdownMenuItem(
                    child: Text("ALTA"),
                    value: "ALTA",
                    onTap: () => {_filtrarPrioridade("Prioridade", "ALTA")},
                  ),
                ],
                onChanged: (String? prioridade) {
                  setState(() {
                    _prioridadeSelecionada = prioridade!;
                    _filtro = "Prioridade";
                  });
                },
              )
            ],
          ),
          Column(
            children: [
              Text("Filtrar por data de execução: "),
              TextButton(
                  onPressed: () => {_showDatePicker("dataExecucao")},
                  child: Text("Selecione a data para filtrar")),
              Text(
                  "Data selecionada: ${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}")
            ],
          ),
          Column(
            children: [
              Text("Filtrar por data de criação: "),
              TextButton(
                  onPressed: () => {_showDatePicker("dataCriacao")},
                  child: Text("Selecione a data para filtrar")),
              Text(
                  "Data selecionada: ${DateFormat('dd/MM/yyyy').format(_dataCricaoSelecionada)}")
            ],
          ),
          Expanded(
            child: widget.listaTarefas.length > 0
                ? ListView.builder(
                    itemCount:
                        _filtrarPrioridade(_filtro, _prioridadeSelecionada)
                            .length,
                    itemBuilder: (context, index) {
                      final tarefa = _filtrarPrioridade(
                          _filtro, _prioridadeSelecionada)[index];
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
                                            .secondary,
                                  ),
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
                                            .secondary,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tarefa.titulo),
                                  Text(
                                    "Prioridade: ${tarefa.prioridade.toString().split(".").last}",
                                    style: TextStyle(
                                      color: _corPrioridade(tarefa.prioridade),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  _modelDeleteTarefa(
                                    context,
                                    tarefa.id,
                                    tarefa.titulo,
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: Text("Não há tarefas cadastradas!")),
          ),
        ],
      ),
    );
  }
}
