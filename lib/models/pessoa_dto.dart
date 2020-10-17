class PessoaDTO {
  final String id;
  final String nome;
  final String email;
  final int classe;

  PessoaDTO(this.id, this.nome, this.email, this.classe);

  PessoaDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        email = json['email'],
        classe = json['classe'];

  @override
  String toString() {
    return 'PessoaDTO[id=$id, nome=$nome, email=$email, classe=$classe]';
  }
}
