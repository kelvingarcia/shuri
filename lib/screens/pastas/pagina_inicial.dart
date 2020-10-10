import 'package:flutter/material.dart';
import 'package:shuri/components/icone_pessoa.dart';
import 'package:shuri/screens/pastas/documentos.dart';
import 'package:shuri/screens/pastas/nova_pasta.dart';

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
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 56.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.crop_square),
                IconePessoa(texto: 'K'),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _pastas.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.folder),
                title: Text(_pastas[index]),
                onTap: () => Navigator.push(
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
    );
  }
}
