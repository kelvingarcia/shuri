class ArquivoPDF {
  final String nome;
  final String arquivo;
  final String idPasta;

  ArquivoPDF(this.nome, this.arquivo, this.idPasta);

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'arquivo': arquivo,
        'idPasta': idPasta,
      };
}
