import 'package:flutter/material.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/screens/documento/aguarda_documento.dart';
import 'package:shuri/screens/documento/documento.dart';

class Documentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pasta'),
      ),
      body: Column(
        children: [
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
