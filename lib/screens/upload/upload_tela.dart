import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/arquivo_pdf.dart';
import 'package:shuri/models/pasta_model.dart';

class UploadTela extends StatefulWidget {
  final String idPasta;
  final String titulo;
  final File arquivo;

  UploadTela({
    @required this.idPasta,
    @required this.titulo,
    @required this.arquivo,
  });

  @override
  _UploadTelaState createState() => _UploadTelaState();
}

class _UploadTelaState extends State<UploadTela> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  List<bool> marcados = List();

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
                    FutureBuilder<PastaModel>(
                      future: TreinaMobileClient.getUmaPasta(widget.idPasta),
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
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.membros.length,
                                itemBuilder: (context, index) {
                                  marcados.add(false);
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: marcados[index],
                                        onChanged: (value) {
                                          setState(() {
                                            marcados[index] = value;
                                          });
                                        },
                                      ),
                                      Text(snapshot.data.membros[index]),
                                    ],
                                  );
                                },
                              );
                            }
                            break;
                        }
                        return Container();
                      },
                    ),
                    Center(
                      child: BotaoRedondo(
                        icon: Icon(Icons.done),
                        text: 'Fazer upload',
                        onPressed: () async {
                          var response = await TreinaMobileClient.postArquivo(
                            ArquivoPDF(
                              nome: _nomeController.text,
                              arquivo: base64.encode(
                                widget.arquivo.readAsBytesSync(),
                              ),
                              idPasta: widget.idPasta,
                            ),
                          );
                          debugPrint(response);
                          Navigator.pop(context);
                        },
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
