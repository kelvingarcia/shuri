import 'package:flutter/material.dart';
import 'package:shuri/components/barra_inferior.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/notificacoes_dto.dart';

class Notificacoes extends StatefulWidget {
  @override
  _NotificacoesState createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  Widget _icone(String tipo){
    switch(tipo){
      case 'ASSINATURA':
        return Icon(Icons.check);
        break;
      case 'USUARIO':
        return Icon(Icons.person);
        break;
      case 'DOCUMENTO':
        return Icon(Icons.article);
        break;
      case 'PASTA':
        return Icon(Icons.folder);
        break;
      case 'EXCLUIR':
        return Icon(Icons.delete);
        break;
      default:
        return Icon(Icons.check);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BarraSuperior(
            textoPessoa: 'K',
            voltar: false,
          ),
          FutureBuilder<List<NotificacoesDTO>>(
            future: TreinaMobileClient.getListaNotificacoes(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('Aguarde...')
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 24.0, left: 8.0, right: 8.0, bottom: 8.0),
                            child: Card(
                              elevation: 10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: _icone(snapshot.data[index].tipo),
                                    title: Text(snapshot.data[index].texto),
                                    subtitle: Text(snapshot.data[index].horario),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  break;
              }
              return Container();
            },
          ),
        ],
      ),
      bottomNavigationBar: BarraInferior(
        notificacoes: true,
      ),
    );
  }
}
