import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuri/http/webclient.dart';
import 'package:shuri/models/arquivo_assinado.dart';
import 'package:shuri/models/arquivo_pdf.dart';
import 'package:shuri/models/documento_dto.dart';
import 'package:shuri/models/documento_model.dart';
import 'package:shuri/models/imagem_arquivo.dart';
import 'package:shuri/models/notificacoes_dto.dart';
import 'package:shuri/models/paginas.dart';
import 'package:shuri/models/pasta_model.dart';
import 'package:shuri/models/pasta_dto.dart';
import 'package:shuri/models/pasta_reponse.dart';
import 'package:shuri/models/pessoa.dart';
import 'package:shuri/models/pessoa_dto.dart';
import 'package:shuri/models/reconhece_request.dart';
import 'package:shuri/models/reconhecimento_token.dart';
import 'package:shuri/models/treina_request.dart';

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
    var reconhecimentoToken = ReconhecimentoToken.fromJson(decodedJson);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', reconhecimentoToken.token);
    prefs.setString(
      'nomeUsuario',
      reconhecimentoToken.reconhecimento.pessoa.nome,
    );
    return reconhecimentoToken;
  }

  static Future<ReconhecimentoToken> reconhecePessoaTeste() async {
    final Response response = await client.get(
      baseUrl + 'reconhecePessoaTeste',
      headers: {
        'Content-type': 'application/json',
      },
    );
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    var reconhecimentoToken = ReconhecimentoToken.fromJson(decodedJson);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', reconhecimentoToken.token);
    prefs.setString(
      'nomeUsuario',
      reconhecimentoToken.reconhecimento.pessoa.nome,
    );
    prefs.setString(
      'emailUsuario',
      reconhecimentoToken.reconhecimento.pessoa.email,
    );
    return reconhecimentoToken;
  }

  static Future<PastaResponse> criaNovaPasta(PastaDTO pastaDTO) async {
    var prefs = await SharedPreferences.getInstance();
    var response = await client.post(baseUrl + 'pasta',
        headers: {
          'Content-type': 'application/json',
          'Authorization': prefs.getString('token'),
        },
        body: jsonEncode(pastaDTO.toJson()));
    var nome = prefs.getString('nomeUsuario');
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    var pastaResponse = PastaResponse.fromJson(decodedJson);
    if (response.statusCode == 200) {
      if (pastaDTO.id == null) {
        await salvaNotificacao(
          NotificacoesDTO(
            texto: '$nome criou a pasta ' + pastaDTO.nome,
            tipo: 'PASTA',
            idPasta: pastaResponse.id,
          ),
        );
      } else {
        await salvaNotificacao(
          NotificacoesDTO(
            texto: '$nome editou a pasta ' + pastaDTO.nome,
            tipo: 'PASTA',
            idPasta: pastaResponse.id,
          ),
        );
      }
    }
    return pastaResponse;
  }

  // static Future<Imagem> teste(String nomeArquivo) async {
  //   var request =
  //       await client.get('http://192.168.0.3:8087/testaImagem/' + nomeArquivo);
  //   final Map<String, dynamic> decodedJson = jsonDecode(request.body);
  //   String imagemString = decodedJson['imagem'];
  //   var imagemBytes = base64Decode(imagemString);
  //   return Imagem(decodedJson['nome'], imagemBytes);
  // }

  static Future<Paginas> getDocumentoArquivo(String nomeArquivo) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var email = prefs.getString('emailUsuario');
    var request = await client.get(
      baseUrl + 'documentoArquivo/' + nomeArquivo + '/' + email,
      headers: {
        'Authorization': token,
      },
    );
    final Map<String, dynamic> decodedJson = jsonDecode(request.body);
    List<dynamic> arquivoDynamic = decodedJson['arquivo'];
    var arquivoImagens =
        arquivoDynamic.map((e) => ImagemArquivo.fromJson(e)).toList();
    var arquivo = arquivoImagens.map((e) => base64Decode(e.arquivo)).toList();
    return Paginas(arquivo);
  }

  // static Future<String> postTeste(ImagemPost imagemPost) async {
  //   var request = await client.post(
  //     'http://192.168.0.3:8087/imagemFromFront',
  //     headers: {'Content-type': 'application/json'},
  //     body: jsonEncode(imagemPost.toJson()),
  //   );
  //   return request.body;
  // }

  static Future<String> postArquivo(ArquivoPDF arquivoPDF) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var nome = prefs.getString('nomeUsuario');
    arquivoPDF.descricao = 'Compartilhado por ' + nome;
    var request = await client.post(
      baseUrl + 'documento',
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(arquivoPDF.toJson()),
    );
    if (request.statusCode == 200) {
      if (arquivoPDF.id == null) {
        await salvaNotificacao(
          NotificacoesDTO(
            texto: '$nome adicionou o documento ' + arquivoPDF.nome,
            tipo: 'DOCUMENTO',
            idPasta: arquivoPDF.idPasta,
          ),
        );
      } else {
        await salvaNotificacao(
          NotificacoesDTO(
            texto: '$nome editou o documento ' + arquivoPDF.nome,
            tipo: 'DOCUMENTO',
            idPasta: arquivoPDF.idPasta,
          ),
        );
      }
    }
    return request.body;
  }

  static Future<List<PastaResponse>> listaDePastas() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var email = prefs.getString('emailUsuario');
    var response = await client.get(
      baseUrl + 'listaDePastas/' + email,
      headers: {
        'Authorization': token,
      },
    );
    List<dynamic> listaPastas = jsonDecode(response.body);
    return listaPastas
        .map((element) => PastaResponse.fromJson(element))
        .toList();
  }

  static Future<PessoaDTO> usuarioLogado() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await client.get(
      baseUrl + 'usuarioLogado',
      headers: {
        'Authorization': token,
      },
    );
    return PessoaDTO.fromJson(jsonDecode(response.body));
  }

  static Future<Pessoa> buscaPorEmail(String email) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await client.get(
      'http://192.168.0.6:8085/email/' + email,
      headers: {
        'Authorization': token,
      },
    );
    if (response.body != '') return Pessoa.fromJson(jsonDecode(response.body));
    return null;
  }

  static Future<List<DocumentoDTO>> documentosNaPasta(String idPasta) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var email = prefs.getString('emailUsuario');
    var response = await client.get(
      baseUrl + 'documentosNaPasta/' + idPasta + '/' + email,
      headers: {
        'Authorization': token,
      },
    );
    List<dynamic> listaDocs = jsonDecode(response.body);
    return listaDocs.map((element) => DocumentoDTO.fromJson(element)).toList();
  }

  static Future<PastaModel> getUmaPasta(String idPasta) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await client.get(
      baseUrl + 'umaPasta/' + idPasta,
      headers: {
        'Authorization': token,
      },
    );
    return PastaModel.fromJson(jsonDecode(response.body));
  }

  static Future<PastaModel> desativaPasta(String id) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await client.delete(
      baseUrl + 'pasta/' + id,
      headers: {
        'Authorization': token,
      },
    );
    var nome = prefs.getString('nomeUsuario');
    var pastaModel = PastaModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      await salvaNotificacao(
        NotificacoesDTO(
          texto: '$nome excluiu a pasta ' + pastaModel.nomePasta,
          tipo: 'EXCLUIR',
          idPasta: id,
        ),
      );
    }
    return pastaModel;
  }

  static Future<DocumentoDTO> assinaDocumento(
      List<String> arquivoAssinado, String idDocumento) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var email = prefs.getString('emailUsuario');
    var nome = prefs.getString('nomeUsuario');
    var arquivoPost = ArquivoAssinado(email, arquivoAssinado);
    var response = await client.post(
      baseUrl + 'assinaDocumento/' + idDocumento,
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(arquivoPost.toJson()),
    );
    var documentoDTO = DocumentoDTO.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      await salvaNotificacaoDocumento(
        NotificacoesDTO(
          texto: '$nome assinou o documento ' + documentoDTO.nome,
          tipo: 'ASSINATURA',
        ),
      );
    }
    return documentoDTO;
  }

  static Future<DocumentoDTO> desativaDocumento(String id) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var nome = prefs.getString('nomeUsuario');
    var response = await client.delete(
      baseUrl + 'documento/' + id,
      headers: {
        'Authorization': token,
      },
    );
    var documentoDTO = DocumentoDTO.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      await salvaNotificacaoDocumento(
        NotificacoesDTO(
          texto: '$nome excluiu o documento ' + documentoDTO.nome,
          tipo: 'ASSINATURA',
        ),
      );
    }
    return documentoDTO;
  }

  static Future<DocumentoModel> getDocumentoCompleto(String idDocumento) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await client.get(
      baseUrl + 'getDocumento/' + idDocumento,
      headers: {
        'Authorization': token,
      },
    );
    return DocumentoModel.fromJson(jsonDecode(response.body));
  }

  static Future<NotificacoesDTO> salvaNotificacao(
      NotificacoesDTO notificacoesDTO) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await client.post(
      baseUrl + 'notificacao',
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(notificacoesDTO.toJson()),
    );
    return NotificacoesDTO.fromJson(jsonDecode(response.body));
  }

  static Future<NotificacoesDTO> salvaNotificacaoDocumento(
      NotificacoesDTO notificacoesDTO) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var email = prefs.getString('emailUsuario');
    var response = await client.post(
      baseUrl + 'notificacao/' + email,
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(notificacoesDTO.toJson()),
    );
    return NotificacoesDTO.fromJson(jsonDecode(response.body));
  }

  static Future<List<NotificacoesDTO>> getListaNotificacoes() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var email = prefs.getString('emailUsuario');
    var response = await client.get(
      baseUrl + 'notificacoes/' + email,
      headers: {
        'Authorization': token,
      },
    );
    List<dynamic> listaNotificacoes = jsonDecode(response.body);
    return listaNotificacoes
        .map((element) => NotificacoesDTO.fromJson(element))
        .toList()
        .reversed.toList();
  }
}
