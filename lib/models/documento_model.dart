class DocumentoModel {
  final String id;
	final String nome;
	final List<String> assinantes;

  DocumentoModel(this.id, this.nome, this.assinantes);

  DocumentoModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      nome = json['nome'],
      assinantes = json['assinantes'].cast<String>();
}