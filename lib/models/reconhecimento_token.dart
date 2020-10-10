import 'package:shuri/models/reconhecimento.dart';

class ReconhecimentoToken {
  final Reconhecimento reconhecimento;
  final String token;

  ReconhecimentoToken(this.reconhecimento, this.token);

  ReconhecimentoToken.fromJson(Map<String, dynamic> json)
      : reconhecimento = Reconhecimento.fromJson(json['reconhecimento']),
        token = json['token'];
}
