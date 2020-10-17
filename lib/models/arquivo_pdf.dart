class ArquivoPDF {
  final String nome;
  final String arquivo;

  ArquivoPDF(this.nome, this.arquivo);

  Map<String, dynamic> toJson() => {'nome': nome, 'arquivo': arquivo};
}
