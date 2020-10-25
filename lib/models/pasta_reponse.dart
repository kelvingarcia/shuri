class PastaResponse {
  final String id;
  final String nomePasta;
  final String descricao;

  PastaResponse(this.id, this.nomePasta, this.descricao);

  PastaResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nomePasta = json['nome'],
        descricao = json['descricao'];
}
