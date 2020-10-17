class PastaResponse {
  final String nomePasta;
  final String descricao;

  PastaResponse(this.nomePasta, this.descricao);

  PastaResponse.fromJson(Map<String, dynamic> json)
      : nomePasta = json['nome'],
        descricao = json['descricao'];
}
