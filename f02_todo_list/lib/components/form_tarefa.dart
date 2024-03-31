import 'package:f02_todo_list/model/prioridade.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormTarefa extends StatefulWidget {
  Function(String, String, String, Prioridade, DateTime) onSubmit;
  FormTarefa(this.onSubmit);

  @override
  State<FormTarefa> createState() => _FormTarefaState();
}

class _FormTarefaState extends State<FormTarefa> {
  final _tarefaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _comentariosController = TextEditingController();
  Prioridade _prioridadeSelecionada = Prioridade.BAIXA;
  DateTime _dataSelecionada = DateTime.now();

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
      widget.onSubmit(
          titulo, descricao, comentarios, prioridade, _dataSelecionada);
    }

    _showDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
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

    return Container(
      child: Column(
        children: [
          TextField(
            controller: _tarefaController,
            decoration:
                const InputDecoration(labelText: 'Insira o título da tarefa'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(
                labelText: 'Insira a descrição da tarefa'),
          ),
          TextField(
            controller: _comentariosController,
            decoration: const InputDecoration(
                labelText: 'Insira comentarios sobre a tarefa'),
          ),
          DropdownButton<Prioridade>(
              value: _prioridadeSelecionada,
              items: const [
                DropdownMenuItem(child: Text("BAIXA"), value: Prioridade.BAIXA),
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
                    onPressed: _showDatePicker, child: Text('Selecionar data'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: _submitForm, child: Text('Cadastrar tarefa')),
          )
        ],
      ),
    );
  }
}
