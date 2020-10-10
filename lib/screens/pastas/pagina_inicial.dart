import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/pasta.dart';
import 'package:shuri/screens/pastas/nova_pasta.dart';

import 'documentos.dart';

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  List<String> _pastas = ['Contratação'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BarraSuperior(
            textoPessoa: 'K',
            voltar: false,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _pastas.length,
            itemBuilder: (context, index) {
              return Pasta(
                nomePasta: _pastas[index],
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Documentos(),
                  ),
                ),
              );
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
          final String novaPasta = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovaPasta(),
            ),
          );
          if (novaPasta != null) {
            setState(() {
              _pastas.add(novaPasta);
            });
          }
        },
      ),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(255, 190, 74, 1),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.folder,
              color: Colors.white,
            ),
            Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
