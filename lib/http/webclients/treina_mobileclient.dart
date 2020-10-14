import 'dart:convert';

import 'package:http/http.dart';
import 'package:shuri/http/webclient.dart';
import 'package:shuri/models/arquivo_pdf.dart';
import 'package:shuri/models/pessoa_dto.dart';
import 'package:shuri/models/reconhece_request.dart';
import 'package:shuri/models/reconhecimento_token.dart';
import 'package:shuri/models/treina_request.dart';
import 'package:shuri/screens/documento/documento_tela.dart';

class TreinaMobileClient {
  static Future<PessoaDTO> postPessoa(TreinaRequest treinaRequest) async {
    final String treinaRequestJson = jsonEncode(treinaRequest.toJson());

    final Response response = await client.post(baseUrl + 'cadastraPessoa',
        headers: {'Content-type': 'application/json'}, body: treinaRequestJson);

    return PessoaDTO.fromJson(jsonDecode(response.body));
  }

  static Future<ReconhecimentoToken> reconhecePessoa(
      ReconheceRequest reconheceRequest) async {
    final Response response = await client.post(baseUrl + 'reconhecePessoa',
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(reconheceRequest.toJson()));
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return ReconhecimentoToken.fromJson(decodedJson);
  }

  static Future<Imagem> teste() async {
    var request = await client.get('http://192.168.0.6:8087/imagem');
    final Map<String, dynamic> decodedJson = jsonDecode(request.body);
    String imagemString = decodedJson['imagem'];
    var imagemBytes = base64Decode(imagemString);
    return Imagem(imagemBytes);
  }

  static Future<String> postTeste(ImagemPost imagemPost) async {
    var request = await client.post(
      'http://192.168.0.6:8087/imagemFromFront',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(imagemPost.toJson()),
    );
    return request.body;
  }

  static Future<String> postArquivo(ArquivoPDF arquivoPDF) async {
    var request = await client.post(
      'http://192.168.0.6:8087/mandaArquivo',
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(arquivoPDF.toJson()),
    );
    return request.body;
  }
}
