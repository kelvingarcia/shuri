import 'package:flutter/material.dart';
import 'package:shuri/components/barra_inferior.dart';
import 'package:shuri/components/item_menu.dart';

class Configuracoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          ),
          ItemMenu(
            icone: Icons.report_problem,
            texto: 'Relatar um problema',
            borda: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraInferior(
        settings: true,
      ),
    );
  }
}
