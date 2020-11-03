class ImagemArquivo {
  final String arquivo;

  ImagemArquivo(this.arquivo);

  ImagemArquivo.fromJson(Map<String, dynamic> json) : arquivo = json['arquivo'];
}
