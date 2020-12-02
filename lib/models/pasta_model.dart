class PastaModel {
	final String id;
	final String nomePasta;
	final String descricao;
	final List<String> administradores;
	final List<String> membros;
	final List<String> documentos;

  PastaModel(this.id, this.nomePasta, this.descricao, this.administradores, this.membros, this.documentos);

  PastaModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      nomePasta = json['nomePasta'],
      descricao = json['descricao'],
      administradores = json['administradores'].cast<String>(),
      membros = json['membros'].cast<String>(),
      documentos = json['documentos'].cast<String>();
}