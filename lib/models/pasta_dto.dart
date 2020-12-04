class PastaDTO {
  final String id;
  final String nome;
  final String descricao;
  final List<String> emails;

  PastaDTO(this.id, this.nome, this.descricao, this.emails);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'emails': emails,
      };

  @override
  String toString() {
    return 'PastaDTO[nome=$nome, descricao=$descricao, emails=$emails]';
  }
}
