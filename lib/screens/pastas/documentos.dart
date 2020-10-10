import 'package:flutter/material.dart';
import 'package:shuri/components/barra_superior.dart';
import 'package:shuri/components/icone_pessoa.dart';
import 'package:shuri/components/pasta.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/screens/documento/aguarda_documento.dart';
import 'package:shuri/screens/documento/documento.dart';

class Documentos extends StatelessWidget {
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
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Contrato'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AguardaDocumento(),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Termo de aceite'),
            onTap: () async {
              var imagem = await TreinaMobileClient.teste();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Documento(imagem: imagem),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
