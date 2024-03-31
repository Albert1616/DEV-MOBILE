import "package:f02_todo_list/components/form_edit_tarefa.dart";
import "package:f02_todo_list/main.dart";
import "package:flutter/material.dart";

import "../model/prioridade.dart";
import "../model/tarefa.dart";

class TarefaDetalhes extends StatefulWidget {
  Tarefa tarefa;
  Function(String) onDelete;
  Function(Tarefa) onUpdate;
  TarefaDetalhes(
      {required this.tarefa, required this.onDelete, required this.onUpdate});
  @override
  State<TarefaDetalhes> createState() => _TarefaDetalhesState();
}

class _TarefaDetalhesState extends State<TarefaDetalhes> {
  _deletarTarefa(String id) {
    widget.onDelete(id);
    Navigator.pop(context);
  }

  _onUpdate(String titulo, String descricao, String comentarios,
      Prioridade prioridade, DateTime data) {
    widget.tarefa.titulo = titulo;
    widget.tarefa.descricao = descricao;
    widget.tarefa.comentarios = comentarios;
    widget.tarefa.prioridade = prioridade;
    widget.tarefa.data = data;
    widget.onUpdate(widget.tarefa);
    Navigator.pop(context);
  }

  _showModal() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return FormEditTarefa(tarefa: widget.tarefa, onUpdate: _onUpdate);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da tarefa"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Titulo: ${widget.tarefa.titulo}"),
              Text(
                  "Prioridade: ${widget.tarefa.prioridade.toString().split(".").last}"),
              Text("Descrição: ${widget.tarefa.descricao}"),
              Text("Comentários: ${widget.tarefa.comentarios}"),
              Text("Data de execução: ${widget.tarefa.data}"),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _deletarTarefa(widget.tarefa.id);
                      },
                      child: Text("Deletar")),
                  SizedBox(width: 30),
                  ElevatedButton(
                      onPressed: () {
                        _showModal();
                      },
                      child: Text("Editar"))
                ],
              )
            ]),
      ),
    );
  }
}
