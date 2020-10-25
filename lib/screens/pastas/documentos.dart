import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/documento_card.dart';
import 'package:shuri/components/icone_pessoa.dart';
import 'package:shuri/components/pasta.dart';
import 'package:shuri/models/documento.dart';
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
  _DocumentosState createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  final List<Documento> _documentos = List();

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
                          texto: 'G',
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
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _documentos.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AguardaDocumento(
                      nomeArquivo: _documentos[index].nome,
                    ),
                  ),
                ),
                child: DocumentoCard(
                  data: _documentos[index].data,
                  nomeDocumento: _documentos[index].nome,
                  horario: _documentos[index].horario,
                  descricao: _documentos[index].descricao,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult result = await FilePicker.platform.pickFiles();

          if (result != null) {
            File file = File(result.files.single.path);
            var novoDocumento = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadTela(
                  idPasta: widget.idPasta,
                  titulo: file.path.split('/').last.split('.').first,
                  arquivo: file,
                ),
              ),
            );
            if (novoDocumento != null) {
              setState(() {
                _documentos.add(
                  Documento(
                    data: 'Hoje',
                    nome: novoDocumento,
                    horario: DateTime.now().hour.toString() +
                        ':' +
                        DateTime.now().minute.toString(),
                    descricao: 'Compartilhado por Kelvin',
                  ),
                );
              });
            }
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
