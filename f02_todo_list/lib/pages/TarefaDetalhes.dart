import "package:flutter/material.dart";

import "../model/tarefa.dart";

class TarefaDetalhes extends StatefulWidget {
  Tarefa tarefa;
  TarefaDetalhes({required this.tarefa});
  @override
  State<TarefaDetalhes> createState() => _TarefaDetalhesState();
}

class _TarefaDetalhesState extends State<TarefaDetalhes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da tarefa"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Titulo: ${widget.tarefa.titulo}"),
              Text(
                  "Prioridade: ${widget.tarefa.prioridade.toString().split(".").last}"),
              Text("Descrição: ${widget.tarefa.descricao}"),
              Text("Data de execução: ${widget.tarefa.data}"),
            ]),
      ),
    );
  }
}
