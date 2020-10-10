class TreinaRequest {
  final String nome;
  final String email;
  String video;

  TreinaRequest({this.nome, this.email, this.video});

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'email': email,
        'video': video,
      };
}
