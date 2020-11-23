import 'package:flutter/material.dart';
import 'package:shuri/screens/configuracoes/configuracoes.dart';
import 'package:shuri/screens/notificacoes/notificacoes.dart';
import 'package:shuri/screens/pastas/pagina_inicial.dart';

class BarraInferior extends StatelessWidget {
  final bool pastas;
  final bool notificacoes;
  final bool settings;

  const BarraInferior({
    Key key,
    this.pastas = false,
    this.notificacoes = false,
    this.settings = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaInicial(),
              ),
            ),
            child: Icon(
              pastas ? Icons.folder : Icons.folder_outlined,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Notificacoes(),
              ),
            ),
            child: Icon(
              notificacoes ? Icons.notifications : Icons.notifications_outlined,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Configuracoes(),
              ),
            ),
            child: Icon(
              settings ? Icons.settings : Icons.settings_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
