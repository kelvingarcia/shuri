import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;

import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/paginas.dart';
import 'package:shuri/models/reconhece_request.dart';
import 'package:shuri/screens/documento/envio_sucesso.dart';
import 'package:shuri/screens/sucesso/tela_sucesso.dart';

class DocumentoTela extends StatefulWidget {
  final Paginas paginas;

  DocumentoTela({Key key, this.paginas}) : super(key: key);

  @override
  _DocumentoTelaState createState() => _DocumentoTelaState();
}

class _DocumentoTelaState extends State<DocumentoTela> {
  List<GlobalKey> listaKeys = List();

  @override
  void initState() {
    super.initState();
    debugPrint('iniciou tela');
    widget.paginas.arquivo.forEach((element) {
      listaKeys.add(GlobalKey());
    });
  }

  Future<void> _captureEach(GlobalKey key, List<Uint8List> listaPng) async {
    Scrollable.ensureVisible(key.currentContext);
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    listaPng.add(pngBytes);
  }

  void _capturePng() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text('Enviando documento'),
            ],
          ),
        );
      },
    );
    try {
      print('inside');
      // Scrollable.ensureVisible(listaKeys.last.currentContext);
      // RenderRepaintBoundary boundary =
      //     listaKeys.last.currentContext.findRenderObject();
      // await Future.delayed(const Duration(seconds: 3));
      // ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      // ByteData byteData =
      //     await image.toByteData(format: ui.ImageByteFormat.png);
      // var pngBytes = byteData.buffer.asUint8List();
      List<Uint8List> listaPng = List();

      listaKeys.forEach((key) async {
        await _captureEach(listaKeys.first, listaPng);
      });

      // Scrollable.ensureVisible(listaKeys[1].currentContext);
      // RenderRepaintBoundary boundary2 =
      //     listaKeys[1].currentContext.findRenderObject();
      // await Future.delayed(const Duration(seconds: 1));
      // ui.Image image2 = await boundary2.toImage(pixelRatio: 3.0);
      // ByteData byteData2 =
      //     await image2.toByteData(format: ui.ImageByteFormat.png);
      // var pngBytes2 = byteData2.buffer.asUint8List();
      // listaPng.add(pngBytes2);

      // Scrollable.ensureVisible(listaKeys[2].currentContext);
      // RenderRepaintBoundary boundary3 =
      //     listaKeys[2].currentContext.findRenderObject();
      // await Future.delayed(const Duration(seconds: 1));
      // ui.Image image3 = await boundary3.toImage(pixelRatio: 3.0);
      // ByteData byteData3 =
      //     await image3.toByteData(format: ui.ImageByteFormat.png);
      // var pngBytes3 = byteData3.buffer.asUint8List();
      // listaPng.add(pngBytes3);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TesteImagens(
            imagens: listaPng,
          ),
        ),
      );
      // var bs64 = base64Encode(pngBytes);
      // print(pngBytes);
      // print(bs64);
      // setState(() {});
      // var s = await TreinaMobileClient.postTeste(ImagemPost('Teste', bs64));
      // if (s == 'Deu certo') {
      //   await Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => TelaSucesso(
      //         mensagem: 'Documento enviado com sucesso',
      //         textoBotoes: [],
      //         funcaoBotoes: [],
      //       ),
      //     ),
      //   );
      //   Navigator.pop(context);
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documento'),
      ),
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
        maxScale: 4,
        child: Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.paginas.arquivo.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImagemComAssinatura(
                    imagem: widget.paginas.arquivo[index],
                    globalKey: listaKeys[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnvioSucesso(),
          ),
        ),
      ),
    );
  }
}

class Assinatura extends StatefulWidget {
  @override
  _AssinaturaState createState() => _AssinaturaState();
}

class _AssinaturaState extends State<Assinatura> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assinatura'),
      ),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
                  object.localToGlobal(details.localPosition);
              _points = List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: CustomPaint(
            painter: Signature(
              points: _points,
              strokeWidth: 3.0,
            ),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.pop(context, _points),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;
  double strokeWidth;

  Signature({this.points, this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}

class TesteImagens extends StatelessWidget {
  final List<Uint8List> imagens;

  const TesteImagens({Key key, this.imagens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: imagens.length,
        itemBuilder: (context, index) {
          return Image.memory(imagens[index]);
        },
      ),
    );
  }
}

class ImagemComAssinatura extends StatefulWidget {
  final Uint8List imagem;
  final GlobalKey globalKey;

  ImagemComAssinatura({
    Key key,
    this.imagem,
    this.globalKey,
  }) : super(key: key);

  @override
  _ImagemComAssinaturaState createState() => _ImagemComAssinaturaState();
}

class _ImagemComAssinaturaState extends State<ImagemComAssinatura>
    with AutomaticKeepAliveClientMixin {
  List<Offset> _points = <Offset>[];
  double xPosition = 190;
  double yPosition = 190;

  double gdHeight = 150;
  double gdWidth = 200;

  double circleBottomLeft = 1;
  double circleTopRight = 1;

  double circleBottomRightX = 1;
  double circleBottomRightY = 1;

  double bolinha1 = 95;
  double bolinha2 = 95;

  double strokeWidth = 3.0;
  bool visibilidade = false;

  BorderStyle borderStyle = BorderStyle.none;
  BuildContext contextGlobal;

  @override
  bool get wantKeepAlive => true;

  void navegarParaAssinatura() async {
    final List<Offset> pointsFromAssinatura = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Assinatura(),
      ),
    );
    if (pointsFromAssinatura != null) {
      var reduceMaxDx = pointsFromAssinatura.reduce((value, element) {
        if (element != null) {
          if (value.dx > element.dx) {
            return value;
          } else {
            return element;
          }
        } else {
          return value;
        }
      });
      var reduceMinDx = pointsFromAssinatura.reduce((value, element) {
        if (element != null) {
          if (value.dx < element.dx) {
            return value;
          } else {
            return element;
          }
        } else {
          return value;
        }
      });
      var reduceMaxDy = pointsFromAssinatura.reduce((value, element) {
        if (element != null) {
          if (value.dy > element.dy) {
            return value;
          } else {
            return element;
          }
        } else {
          return value;
        }
      });
      var reduceMinDy = pointsFromAssinatura.reduce((value, element) {
        if (element != null) {
          if (value.dy < element.dy) {
            return value;
          } else {
            return element;
          }
        } else {
          return value;
        }
      });
      List<Offset> pointsNew = List();
      pointsFromAssinatura.forEach((element) {
        if (element != null) {
          pointsNew.add(Offset(
              (element.dx - reduceMinDx.dx) +
                  (MediaQuery.of(context).size.width * 0.05),
              (element.dy - reduceMinDy.dy) +
                  (MediaQuery.of(context).size.height * 0.025)));
        } else {
          pointsNew.add(element);
        }
      });
      setState(() {
        _points = pointsNew;
        gdWidth = (reduceMaxDx.dx - reduceMinDx.dx) +
            (MediaQuery.of(context).size.width * 0.1);
        gdHeight = (reduceMaxDy.dy - reduceMinDy.dy) +
            (MediaQuery.of(context).size.height * 0.05);
        circleBottomLeft = gdHeight;
        circleTopRight = gdWidth;
        circleBottomRightY = gdHeight;
        circleBottomRightX = gdWidth;
        visibilidade = true;
        borderStyle = BorderStyle.solid;
        strokeWidth = 3.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      setState(() {
        bolinha1 = 190 - (MediaQuery.of(context).size.width * 0.013);
        bolinha2 = 190 - (MediaQuery.of(context).size.width * 0.013);
      });
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _showSobre();
    });
  }

  Future<void> _showSobre() async {
    return showDialog<void>(
      context: contextGlobal,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Clique em cima da página para assinar'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
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
    super.build(context);
    contextGlobal = context;
    return RepaintBoundary(
      key: widget.globalKey,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (visibilidade) {
                setState(() {
                  visibilidade = false;
                  borderStyle = BorderStyle.none;
                });
              } else {
                navegarParaAssinatura();
              }
            },
            child: Image.memory(widget.imagem),
          ),
          Positioned(
            top: yPosition,
            left: xPosition,
            height: gdHeight,
            width: gdWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                  style: borderStyle,
                ),
              ),
              child: GestureDetector(
                onPanUpdate: (tapInfo) {
                  setState(() {
                    visibilidade = true;
                    borderStyle = BorderStyle.solid;
                    xPosition += tapInfo.delta.dx;
                    yPosition += tapInfo.delta.dy;
                    bolinha1 += tapInfo.delta.dx;
                    bolinha2 += tapInfo.delta.dy;
                  });
                },
                onTap: () {
                  setState(() {
                    visibilidade = true;
                    borderStyle = BorderStyle.solid;
                  });
                },
                child: CustomPaint(
                  painter: Signature(
                    points: _points,
                    strokeWidth: strokeWidth,
                  ),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          Positioned(
            left: bolinha1,
            top: bolinha2,
            child: Visibility(
              visible: visibilidade,
              child: GestureDetector(
                onPanUpdate: (tapInfo) {
                  setState(() {
                    bolinha2 += tapInfo.delta.dy;
                    yPosition += tapInfo.delta.dy;
                    var oldGdHeight = gdHeight;
                    gdHeight -= tapInfo.delta.dy;
                    var porcentagem = gdHeight / oldGdHeight;
                    var valorX = (gdWidth - (gdWidth * porcentagem));
                    gdWidth -= valorX;
                    bolinha1 += valorX;
                    xPosition += valorX;
                    _points = _points.map((e) {
                      if (e != null) {
                        return Offset(
                          e.dx * porcentagem,
                          e.dy * porcentagem,
                        );
                      } else {
                        return e;
                      }
                    }).toList();
                    strokeWidth = strokeWidth * porcentagem;
                  });
                },
                child: Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
