class ArquivoPDF {
  final String arquivo;

  ArquivoPDF(this.arquivo);

  Map<String, dynamic> toJson() => {'arquivo': arquivo};
}
