import 'package:flutter/material.dart';
import 'package:shuri/models/pessoa_dto.dart';
import 'package:shuri/models/predicao_confianca.dart';
import 'package:shuri/models/reconhece_request.dart';
import 'package:shuri/models/reconhecimento.dart';
import 'package:shuri/models/reconhecimento_token.dart';
import 'package:shuri/screens/pastas/pagina_inicial.dart';

class SignInSucesso extends StatefulWidget {
  final ReconheceRequest reconheceRequest;

  SignInSucesso(this.reconheceRequest);

  @override
  _SignInSucessoState createState() => _SignInSucessoState();
}

class _SignInSucessoState extends State<SignInSucesso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                            'Reconhecimento concluído!',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                reconhecimentoToken.reconhecimento.pessoa.nome,
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                              Text(
                                reconhecimentoToken.reconhecimento.pessoa.email,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'Prosseguir',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Tentar novamente',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Tentar novamente',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
