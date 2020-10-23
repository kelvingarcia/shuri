import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/arquivo_pdf.dart';

class UploadTela extends StatefulWidget {
  final String titulo;
  final File arquivo;

  UploadTela({
    @required this.titulo,
    @required this.arquivo,
  });

  @override
  _UploadTelaState createState() => _UploadTelaState();
}

class _UploadTelaState extends State<UploadTela> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  bool kelvin = false;
  bool welington = false;
  bool grillo = false;

  @override
  void initState() {
    _nomeController.text = widget.titulo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BarraSuperior(
              textoPessoa: 'K',
              voltar: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.article,
                size: 128.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text('Quem deve assinar:'),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: kelvin,
                          onChanged: (value) {
                            setState(() {
                              kelvin = value;
                            });
                          },
                        ),
                        Text('kelvin@email.com'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: welington,
                          onChanged: (value) {
                            setState(() {
                              welington = value;
                            });
                          },
                        ),
                        Text('welington@email.com'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: grillo,
                          onChanged: (value) {
                            setState(() {
                              grillo = value;
                            });
                          },
                        ),
                        Text('grillo@email.com'),
                      ],
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: () async {
                          await TreinaMobileClient.postArquivo(
                            ArquivoPDF(
                              _nomeController.text,
                              base64.encode(
                                widget.arquivo.readAsBytesSync(),
                              ),
                            ),
                          );
                          Navigator.pop(context, _nomeController.text);
                        },
                        child: Text('Fazer upload'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
