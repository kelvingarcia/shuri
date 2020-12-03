import 'package:flutter/material.dart';
import 'package:shuri/components/barra_inferior.dart';
import 'package:shuri/components/barra_superior.dart';

class Notificacoes extends StatefulWidget {
  @override
  _NotificacoesState createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BarraSuperior(
            textoPessoa: 'K',
            voltar: false,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24.0, left: 8.0, right: 8.0, bottom: 8.0),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.check),
                          title: Text('Kelvin assinou o documento Contrato'),
                          subtitle: Text('8:00 a.m.'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                              'Kelvin adicionou um novo usuário à pasta Primeira pasta'),
                          subtitle: Text('9:00 a.m.'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.article),
                          title: Text('Kelvin adicionou o documento Contrato a Primeira Pasta'),
                          subtitle: Text('8:30 a.m.'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.folder),
                          title: Text('Kelvin criou a pasta Primeira pasta'),
                          subtitle: Text('8:00 a.m.'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraInferior(
        notificacoes: true,
      ),
    );
  }
}
