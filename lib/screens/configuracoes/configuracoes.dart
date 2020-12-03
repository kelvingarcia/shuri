import 'package:flutter/material.dart';
import 'package:shuri/components/barra_inferior.dart';
import 'package:shuri/components/item_menu.dart';
import 'package:shuri/screens/signup/signup.dart';

class Configuracoes extends StatelessWidget {
  Future<void> _showSobre(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sobre'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'O Shuri é um app de assinatura de documento que utiliza reconhecimento facial.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showRelatarProblema(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Relatar problema'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Escreva o problema:'),
                TextField(
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Enviar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 112.0),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.04,
                    ),
                    color: Colors.black,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Text(
                        'K',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ItemMenu(
                icone: Icons.person,
                texto: 'Editar usuário',
                borda: BorderSide.none,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp(editar: true),
                  ),
                ),
              ),
            ),
            ItemMenu(
              icone: Icons.star,
              texto: 'Avaliar o app',
              borda: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            ItemMenu(
              icone: Icons.info,
              texto: 'Sobre',
              borda: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              onTap: () => _showSobre(context),
            ),
            ItemMenu(
              icone: Icons.report_problem,
              texto: 'Relatar um problema',
              borda: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              onTap: () => _showRelatarProblema(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BarraInferior(
        settings: true,
      ),
    );
  }
}
