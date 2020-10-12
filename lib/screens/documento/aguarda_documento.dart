import 'package:flutter/material.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/screens/documento/documento_tela.dart';

class AguardaDocumento extends StatefulWidget {
  @override
  _AguardaDocumentoState createState() => _AguardaDocumentoState();
}

class _AguardaDocumentoState extends State<AguardaDocumento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documento'),
      ),
      body: FutureBuilder<Imagem>(
        future: TreinaMobileClient.teste(),
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
                    Text('Carregando documento')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentoTela(
                      imagem: snapshot.data,
                    ),
                  ),
                ).then((value) {
                  Navigator.pop(context);
                });
              });
              break;
          }
          return Container();
        },
      ),
    );
  }
}
