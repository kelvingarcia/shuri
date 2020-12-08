class ArquivoPDF {
  final String id;
  final String nome;
  final String arquivo;
  String descricao;
  final String dataHora;
  final String idPasta;
  final List<String> assinantes;

  ArquivoPDF({
    this.id,
    this.nome,
    this.arquivo,
    this.descricao,
    this.dataHora,
    this.idPasta,
    this.assinantes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'arquivo': arquivo,
        'idPasta': idPasta,
        'descricao': descricao,
        'assinantes': assinantes,
      };

  ArquivoPDF.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        arquivo = json['arquivo'],
        descricao = json['descricao'],
        dataHora = json['dataHora'],
        idPasta = json['idPasta'],
        assinantes = json['assinantes'].cast<String>();
}
