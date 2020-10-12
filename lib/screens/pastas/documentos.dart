import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/documento_card.dart';
import 'package:shuri/components/icone_pessoa.dart';
import 'package:shuri/components/pasta.dart';
import 'package:shuri/models/documento.dart';

class Documentos extends StatelessWidget {
  final List<Documento> _documentos = [
    Documento(
      data: 'Hoje',
      nome: 'Contrato',
      horario: '12:00 pm',
      descricao: 'Compartilhado por Kelvin Garcia',
    ),
    Documento(
      data: 'Ontem',
      nome: 'Termos de uso',
      horario: '9:00 pm',
      descricao: 'Compartilhado por Kelvin Garcia',
    ),
  ];

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
              nomePasta: 'Contratação',
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
                          texto: 'G',
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
                          texto: 'G',
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
              return DocumentoCard(
                data: _documentos[index].data,
                nomeDocumento: _documentos[index].nome,
                horario: _documentos[index].horario,
                descricao: _documentos[index].descricao,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
