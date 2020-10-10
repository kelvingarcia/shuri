import 'package:flutter/material.dart';
import 'package:shuri/components/icone_pessoa.dart';

class BarraSuperior extends StatelessWidget {
  final String textoPessoa;
  final bool voltar;

  BarraSuperior({@required this.textoPessoa, this.voltar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 56.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(voltar ? Icons.arrow_back : Icons.crop_square),
          IconePessoa(texto: textoPessoa),
        ],
      ),
    );
  }
}
