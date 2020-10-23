import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';

class TelaSucesso extends StatelessWidget {
  final String mensagem;
  final List<String> textoBotoes;
  final List<Function> funcaoBotoes;

  TelaSucesso({
    @required this.mensagem,
    this.textoBotoes,
    this.funcaoBotoes,
  });

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
            padding: const EdgeInsets.only(top: 80.0, bottom: 24.0),
            child: Icon(
              Icons.check_circle,
              size: 80.0,
            ),
          ),
          Text(
            mensagem,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: textoBotoes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: RaisedButton(
                  onPressed: funcaoBotoes[index],
                  child: Text(textoBotoes[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
