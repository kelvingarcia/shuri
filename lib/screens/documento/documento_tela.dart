import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/screens/sucesso/tela_sucesso.dart';

class DocumentoTela extends StatefulWidget {
  final Imagem imagem;

  DocumentoTela({Key key, this.imagem}) : super(key: key);

  @override
  _DocumentoTelaState createState() => _DocumentoTelaState();
}

class _DocumentoTelaState extends State<DocumentoTela> {
  GlobalKey _globalKey = GlobalKey();
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
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      await Future.delayed(const Duration(seconds: 3));
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      var s = await TreinaMobileClient.postTeste(
          ImagemPost(widget.imagem.nome, bs64));
      if (s == 'Deu certo') {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaSucesso(
              mensagem: 'Documento enviado com sucesso',
              textoBotoes: [],
              funcaoBotoes: [],
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      setState(() {
        debugPrint(MediaQuery.of(context).size.width.toString());
        debugPrint(MediaQuery.of(context).size.height.toString());
        bolinha1 = 190 - (MediaQuery.of(context).size.width * 0.013);
        bolinha2 = 190 - (MediaQuery.of(context).size.width * 0.013);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documento'),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: InteractiveViewer(
          panEnabled: false,
          minScale: 0.5,
          maxScale: 4,
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
                child: Image.memory(widget.imagem.imagem),
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
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () => _capturePng(),
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
        title: Text('Flutter Demo Home Page'),
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

class Imagem {
  final String nome;
  final Uint8List imagem;

  Imagem(this.nome, this.imagem);
}

class ImagemPost {
  final String nome;
  final String imagem;

  ImagemPost(this.nome, this.imagem);

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'imagem': imagem,
      };
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
