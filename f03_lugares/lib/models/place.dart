class Place {
  final String id;
  List<String> paises;
  String titulo;
  String imagemUrl;
  List<String> recomendacoes;
  double avaliacao;
  double custoMedio;

  Place({
    required this.id,
    required this.paises,
    required this.titulo,
    required this.imagemUrl,
    required this.recomendacoes,
    required this.avaliacao,
    required this.custoMedio,
  });
}
