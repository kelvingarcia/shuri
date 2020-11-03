class DocumentoDTO {
  final String id;
  final String nome;
  String descricao;
  final String dataHora;

  DocumentoDTO({
    this.id,
    this.nome,
    this.descricao,
    this.dataHora,
  });

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'descricao': descricao,
        'dataHora': dataHora,
      };

  DocumentoDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        descricao = json['descricao'],
        dataHora = json['dataHora'];
}
