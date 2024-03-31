import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/prioridade.dart';
import '../model/tarefa.dart';

class FormEditTarefa extends StatefulWidget {
  Tarefa tarefa;
  Function(String, String, String, Prioridade, DateTime) onUpdate;
  FormEditTarefa({super.key, required this.tarefa, required this.onUpdate});

  @override
  State<FormEditTarefa> createState() => _FormEditTarefaState();
}

class _FormEditTarefaState extends State<FormEditTarefa> {
  final _tarefaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _comentariosController = TextEditingController();
  Prioridade _prioridadeSelecionada = Prioridade.BAIXA;
  DateTime _dataSelecionada = DateTime.now();

  void initState() {
    super.initState();
    _tarefaController.text = widget.tarefa.titulo;
    _descricaoController.text = widget.tarefa.descricao;
    _comentariosController.text = widget.tarefa.comentarios;
    _prioridadeSelecionada = widget.tarefa.prioridade;
  }

  @override
  Widget build(BuildContext context) {
    _submitForm() {
      final titulo = _tarefaController.text;
      final descricao = _descricaoController.text;
      final comentarios = _comentariosController.text;
      final prioridade = _prioridadeSelecionada;
      if (_tarefaController.text.isEmpty) {
        return;
      }
      //passando dado para componente pai
      widget.onUpdate(
          titulo, descricao, comentarios, prioridade, _dataSelecionada);
      Navigator.pop(context);
    }

    _showDatePicker() {
      showDatePicker(
              context: context,
              initialDate: widget.tarefa.data,
              firstDate: DateTime(2024),
              lastDate: DateTime(2025))
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _dataSelecionada = pickedDate;
        });
      });
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: const InputDecoration(
                labelText: 'Insira o título da tarefa',
              ),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                  labelText: 'Insira a descrição da tarefa'),
            ),
            TextField(
              controller: _comentariosController,
              decoration: const InputDecoration(
                  labelText: 'Insira comentários sobre a tarefa'),
            ),
            Text("Prioridade: "),
            DropdownButton<Prioridade>(
                value: _prioridadeSelecionada,
                items: const [
                  DropdownMenuItem(
                      child: Text("BAIXA"), value: Prioridade.BAIXA),
                  DropdownMenuItem(
                      child: Text("NORMAL"), value: Prioridade.NORMAL),
                  DropdownMenuItem(child: Text("ALTA"), value: Prioridade.ALTA),
                ],
                onChanged: (Prioridade? prioridade) {
                  setState(() {
                    _prioridadeSelecionada = prioridade!;
                  });
                }),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        'Data selecionada ${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}'),
                  ),
                  TextButton(
                      onPressed: _showDatePicker,
                      child: Text('Selecionar data'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _submitForm, child: Text('Atualizar tarefa')),
            )
          ],
        ),
      ),
    );
  }
}
