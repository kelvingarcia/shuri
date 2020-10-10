class PredicaoConfianca {
  final int predicao;
  final double confianca;
  final int numeroDeFotos;
  final int fotosReconhecidas;

  PredicaoConfianca(this.predicao, this.confianca, this.numeroDeFotos,
      this.fotosReconhecidas);

  PredicaoConfianca.fromJson(Map<String, dynamic> json)
      : predicao = json['predicao'],
        confianca = json['confianca'],
        numeroDeFotos = json['numeroDeFotos'],
        fotosReconhecidas = json['fotosReconhecidas'];
}
