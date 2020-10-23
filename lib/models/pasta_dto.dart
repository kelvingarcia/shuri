class PastaDTO {
  final String nome;
  final String descricao;
  final List<String> emails;

  PastaDTO(this.nome, this.descricao, this.emails);

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'descricao': descricao,
        'emails': emails,
      };

  @override
  String toString() {
    return 'PastaDTO[nome=$nome, descricao=$descricao, emails=$emails]';
  }
}
