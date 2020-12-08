import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/documento_card.dart';
import 'package:shuri/components/icone_pessoa.dart';
import 'package:shuri/components/pasta.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/documento_dto.dart';
import 'package:shuri/screens/documento/aguarda_documento.dart';
import 'package:shuri/screens/upload/upload_tela.dart';

class Documentos extends StatefulWidget {
  final String idPasta;
  final String nomePasta;
  final String descricao;

  Documentos({
    @required this.idPasta,
    @required this.nomePasta,
    @required this.descricao,
  });

  @override
  DocumentosState createState() => DocumentosState();
}

class DocumentosState extends State<Documentos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BarraSuperior(
            textoPessoa: 'K',
            voltar: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Pasta(
              id: widget.idPasta,
              nomePasta: widget.nomePasta,
              descricao: widget.descricao,
              onPressed: () {},
              divider: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Membros',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconePessoa(
                          texto: 'K',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconePessoa(
                          texto: 'M',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconePessoa(
                          texto: 'W',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<List<DocumentoDTO>>(
            future: TreinaMobileClient.documentosNaPasta(widget.idPasta),
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
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AguardaDocumento(
                                  nomeArquivo: snapshot.data[index].id,
                                ),
                              ),
                            ),
                            child: DocumentoCard(
                              id: snapshot.data[index].id,
                              data:
                                  snapshot.data[index].dataHora.substring(0, 5),
                              nomeDocumento: snapshot.data[index].nome ?? '',
                              horario:
                                  snapshot.data[index].dataHora.substring(11),
                              descricao: snapshot.data[index].descricao ?? '',
                              assinado: snapshot.data[index].assinado,
                              documentosState: this,
                              idPasta: widget.idPasta,
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
        onPressed: () async {
          FilePickerResult result = await FilePicker.platform.pickFiles();

          if (result != null) {
            File file = File(result.files.single.path);
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadTela(
                  idPasta: widget.idPasta,
                  titulo: file.path.split('/').last.split('.').first,
                  arquivo: file,
                ),
              ),
            );
            setState(() {});
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
