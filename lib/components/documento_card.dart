import 'package:flutter/material.dart';

class DocumentoCard extends StatelessWidget {
  final String data;
  final String nomeDocumento;
  final String horario;
  final String descricao;

  DocumentoCard({
    @required this.data,
    @required this.nomeDocumento,
    @required this.horario,
    @required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 8.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                data,
                style: TextStyle(fontSize: 16.0),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Icon(
                  Icons.article,
                  size: 80.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nomeDocumento,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      horario,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      descricao,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
