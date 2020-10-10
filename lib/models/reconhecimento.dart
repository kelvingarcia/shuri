import 'package:shuri/models/pessoa_dto.dart';
import 'package:shuri/models/predicao_confianca.dart';

class Reconhecimento {
  final PessoaDTO pessoa;
  final PredicaoConfianca predicaoConfianca;
  final String statusReconhecimento;

  Reconhecimento(
      this.pessoa, this.predicaoConfianca, this.statusReconhecimento);

  Reconhecimento.fromJson(Map<String, dynamic> json)
      : pessoa = PessoaDTO.fromJson(json['pessoa']),
        predicaoConfianca =
            PredicaoConfianca.fromJson(json['predicaoConfianca']),
        statusReconhecimento = json['statusReconhecimento'];
}
