// import 'dart:convert';

// import 'package:hive/hive.dart';
// import 'package:shuri/models/pessoa_dto.dart';
// import 'package:shuri/models/reconhece_request.dart';
// import 'package:shuri/models/reconhecimento_token.dart';
// import 'package:shuri/models/treina_request.dart';

// class TreinaWebClient {
//   static Future<PessoaDTO> postPessoa(TreinaRequest treinaRequest) async {
//     var request = await HttpRequest.request(
//         'http://localhost:8080/cadastraPessoa',
//         method: 'POST',
//         sendData: jsonEncode(treinaRequest.toJson()),
//         requestHeaders: {
//           'Content-Type': 'application/json',
//           'Access-Control-Allow-Origin': '*'
//         });
//     final Map<String, dynamic> decodedJson = jsonDecode(request.responseText);
//     return PessoaDTO.fromJson(decodedJson);
//   }

//   static Future<ReconhecimentoToken> reconhecePessoa(
//       ReconheceRequest reconheceRequest) async {
//     var request = await HttpRequest.request(
//         'http://localhost:8080/reconhecePessoa',
//         method: 'POST',
//         sendData: jsonEncode(reconheceRequest.toJson()),
//         requestHeaders: {
//           'Content-Type': 'application/json',
//           'Access-Control-Allow-Origin': '*'
//         });
//     var openBox = await Hive.openBox('sessao');
//     print(request.responseText);
//     final Map<String, dynamic> decodedJson = jsonDecode(request.responseText);
//     return ReconhecimentoToken.fromJson(decodedJson);
//   }
// }
