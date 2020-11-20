import 'package:flutter/material.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/pessoa_dto.dart';
import 'package:shuri/models/treina_request.dart';
import 'package:shuri/screens/menu_inicial.dart';

class SignUpSucesso extends StatefulWidget {
  final TreinaRequest treinaRequest;

  SignUpSucesso(this.treinaRequest);

  @override
  _SignUpSucessoState createState() => _SignUpSucessoState();
}

class _SignUpSucessoState extends State<SignUpSucesso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro finalizado'),
      ),
      body: FutureBuilder<PessoaDTO>(
        future:
            Future.value(PessoaDTO('Teste', 'Kelvin', 'kelvin@email.com', 1)),
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
                    Text('Cadastrando...')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final PessoaDTO pessoa = snapshot.data;
                if (pessoa != null) {
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
                            'Cadastro de ' +
                                pessoa.nome +
                                ' realizado com sucesso!',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'Voltar para o menu',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuInicial(),
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
