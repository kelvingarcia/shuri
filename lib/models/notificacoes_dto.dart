class NotificacoesDTO {
  final String texto;
  final String idPasta;
  final String tipo;
  final String horario;

  NotificacoesDTO({
    this.texto,
    this.idPasta,
    this.tipo,
    this.horario,
  });

  Map<String, dynamic> toJson() => {
        'texto': texto,
        'idPasta': idPasta,
        'tipo': tipo,
        'horario': horario,
      };

  NotificacoesDTO.fromJson(Map<String, dynamic> json)
      : texto = json['texto'],
        tipo = json['tipo'],
        idPasta = json['idPasta'],
        horario = json['horario'];
}
