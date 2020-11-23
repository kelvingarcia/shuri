import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

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
            child: const Text('Editar documento'), value: 'editar'),
        PopupMenuItem<String>(
            child: const Text('Excluir documento'), value: 'excluir'),
      ],
      elevation: 8.0,
    );
    if (res == 'excluir') {
      _deletarDocumento(context);
    }
  }

  Rect _getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  Future<void> _deletarDocumento(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza que deseja deletar este documento?'),
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
    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 8.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Visibility(
                        visible: false,
                        child: Icon(Icons.check),
                      ),
                      Text(
                        data,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
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
              InkWell(
                key: key,
                child: Icon(Icons.more_vert),
                onTap: () => _simplePopup(context, key),
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
