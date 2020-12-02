import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:shuri/screens/pastas/nova_pasta.dart';

enum OpcoesMenu { editar, excluir }

class Pasta extends StatelessWidget {
  final String id;
  final String nomePasta;
  final String descricao;
  final Function onPressed;
  final bool divider;

  Pasta({
    @required this.id,
    @required this.nomePasta,
    @required this.onPressed,
    @required this.descricao,
    this.divider = true,
  });

  void _simplePopup(BuildContext context, GlobalKey key) async {
    var rect = RectGetter.getRectFromKey(key);
    var res = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        rect.left,
        rect.top,
        rect.right,
        rect.bottom,
      ),
      items: [
        PopupMenuItem<String>(
            child: const Text('Editar pasta'), value: 'editar'),
        PopupMenuItem<String>(
            child: const Text('Excluir pasta'), value: 'excluir'),
      ],
      elevation: 8.0,
    );
    if (res == 'excluir') {
      _deletarPasta(context);
    }
    if (res == 'editar') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NovaPasta(id: id),
        ),
      );
    }
  }

  Rect _getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  Future<void> _deletarPasta(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza que deseja deletar esta pasta?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Sim'),
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
    var key = RectGetter.createGlobalKey();
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.folder,
                      size: 64.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nomePasta,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(descricao),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  key: key,
                  child: Icon(Icons.more_vert),
                  onTap: () => _simplePopup(context, key),
                ),
              ],
            ),
            Visibility(
              visible: divider,
              child: Divider(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
