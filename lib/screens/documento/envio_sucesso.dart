import 'package:flutter/material.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/models/pessoa_dto.dart';
import 'package:shuri/models/predicao_confianca.dart';
import 'package:shuri/models/reconhece_request.dart';
import 'package:shuri/models/reconhecimento.dart';
import 'package:shuri/models/reconhecimento_token.dart';
import 'package:shuri/screens/pastas/pagina_inicial.dart';

class EnvioSucesso extends StatefulWidget {
  final ReconheceRequest reconheceRequest;

  EnvioSucesso(this.reconheceRequest);

  @override
  _EnvioSucessoState createState() => _EnvioSucessoState();
}

class _EnvioSucessoState extends State<EnvioSucesso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envio'),
      ),
      body: FutureBuilder<ReconhecimentoToken>(
        future: Future.value(
          ReconhecimentoToken(
            Reconhecimento(
                PessoaDTO(
                  'Teste',
                  'Kelvin',
                  'kelvin@email.com',
                  1,
                ),
                PredicaoConfianca(
                  1,
                  100.0,
                  10,
                  10,
                ),
                'RECONHECIDO CORRETAMENTE'),
            'TOKEN',
          ),
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Reconhecendo...')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final ReconhecimentoToken reconhecimentoToken = snapshot.data;
                if (reconhecimentoToken != null) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 96.0,
                        ),
                        Center(
                          child: Text(
                            'Documento enviado!',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        BotaoRedondo(
                          icon: Icon(Icons.arrow_back),
                          text: 'Retornar para a pasta',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaginaInicial(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                      child: Icon(
                        Icons.warning,
                        size: 64,
                      ),
                      visible: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Text(
                        'Nenhuma pessoa encontrada',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    BotaoRedondo(
                      icon: Icon(Icons.refresh),
                      text: 'Tentar novamente',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
              break;
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  child: Icon(
                    Icons.warning,
                    size: 64,
                  ),
                  visible: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'Erro desconhecido',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                BotaoRedondo(
                  icon: Icon(Icons.refresh),
                  text: 'Tentar novamente',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
