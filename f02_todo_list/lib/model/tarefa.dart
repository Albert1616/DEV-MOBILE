import 'prioridade.dart';

class Tarefa {
  String id;
  String titulo;
  String descricao;
  Prioridade prioridade;
  String comentarios;
  DateTime data;
  DateTime data_create = DateTime.now();
  Tarefa(
      {required this.id,
      required this.titulo,
      required this.descricao,
      required this.prioridade,
      required this.data,
      required this.comentarios});
}
