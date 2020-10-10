import 'package:flutter/material.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/reconhece_request.dart';
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
      body: FutureBuilder<ReconhecimentoToken>(
        future: TreinaMobileClient.reconhecePessoa(widget.reconheceRequest),
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
                    Text('Loading')
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
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(
                                reconhecimentoToken.reconhecimento.pessoa.nome,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                reconhecimentoToken
                                    .reconhecimento.predicaoConfianca.predicao
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Text('Prosseguir'),
                            color: Colors.blue,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaginaInicial(),
                              ),
                            ),
                          ),
                        ],
                      ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
