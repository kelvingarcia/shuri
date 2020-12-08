class DocumentoDTO {
  final String id;
  final String nome;
  String descricao;
  final String dataHora;
  final bool assinado;

  DocumentoDTO({
    this.id,
    this.nome,
    this.descricao,
    this.dataHora,
    this.assinado,
  });

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'descricao': descricao,
        'dataHora': dataHora,
        'assinado': assinado,
      };

  DocumentoDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        descricao = json['descricao'],
        dataHora = json['dataHora'],
        assinado = json['assinado'];
}
