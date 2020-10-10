class Pessoa {
  final String id;
  final String nome;
  final String email;
  final int classe;
  final String video;

  Pessoa(this.id, this.nome, this.email, this.classe, this.video);

  Pessoa.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        email = json['email'],
        classe = json['classe'],
        video = json['video'];

  @override
  String toString() {
    return 'Pessoa[id=$id, nome=$nome, email=$email, classe=$classe]';
  }
}
