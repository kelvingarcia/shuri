class ArquivoAssinado {
  final String assinador;
  final List<String> arquivoAssinado;

  ArquivoAssinado(this.assinador, this.arquivoAssinado);

  Map<String, dynamic> toJson() => {
        'assinador': assinador,
        'arquivoAssinado': arquivoAssinado,
      };

}