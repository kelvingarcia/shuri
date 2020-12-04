import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/arquivo_pdf.dart';

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
  List<String> emails = List();
  List<bool> marcados = List();

  @override
  void initState() {
    _nomeController.text = widget.titulo;
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      var pastaModel = await TreinaMobileClient.getUmaPasta(widget.idPasta);
      setState(() {
        emails = pastaModel.membros;
      });
    });
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
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: emails.length,
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
                            Text(emails[index]),
                          ],
                        );
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
