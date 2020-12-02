import 'package:flutter/material.dart';
import 'package:shuri/components/barra_inferior.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/pasta.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/pasta_reponse.dart';
import 'package:shuri/screens/pastas/nova_pasta.dart';

import 'documentos.dart';

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BarraSuperior(
            textoPessoa: 'K',
            voltar: false,
          ),
          FutureBuilder<List<PastaResponse>>(
            future: TreinaMobileClient.listaDePastas(),
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
                          return Pasta(
                            id: snapshot.data[index].id,
                            nomePasta: snapshot.data[index].nomePasta,
                            descricao: snapshot.data[index].descricao,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Documentos(
                                  idPasta: snapshot.data[index].id,
                                  nomePasta: snapshot.data[index].nomePasta,
                                  descricao: snapshot.data[index].descricao,
                                ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovaPasta(),
            ),
          );
          setState(() {});
        },
      ),
      bottomNavigationBar: BarraInferior(
        pastas: true,
      ),
    );
  }
}
