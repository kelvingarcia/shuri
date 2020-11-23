import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shuri/models/reconhece_request.dart';
import 'package:shuri/screens/signin/signin_sucesso.dart';

class SignInVideoMobile extends StatefulWidget {
  final CameraDescription camera;

  SignInVideoMobile({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _SignInVideoMobileState createState() => _SignInVideoMobileState();
}

class _SignInVideoMobileState extends State<SignInVideoMobile> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  IconData icone = Icons.videocam;
  String _start = '5';
  Timer _timer;
  bool visibleTimer = false;
  BuildContext contextGlobal;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();

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
                Text(
                    'Centralize seu rosto na câmera e evite muitos movimentos para que o reconhecimento seja mais preciso.'),
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
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (int.parse(_start) < 1) {
            timer.cancel();
          } else {
            _start = (int.parse(_start) - 1).toString();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    contextGlobal = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconhecimento facial'),
      ),
      body: Stack(
        children: [
          Positioned(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Visibility(
            visible: visibleTimer,
            child: Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: 24.0,
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '00:0' + _start,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(icone),
        onPressed: () async {
          setState(() {
            icone = Icons.close;
            visibleTimer = true;
          });
          startTimer();
          try {
            await _initializeControllerFuture;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.mp4',
            );

            await _controller.prepareForVideoRecording();

            await _controller.startVideoRecording(path);

            await Future.delayed(Duration(seconds: 5));

            await _controller.stopVideoRecording();

            var video = File(path);

            var encode = base64.encode(video.readAsBytesSync());

            var reconheceRequest = ReconheceRequest(encode);

            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInSucesso(null)),
            );

            setState(() {
              icone = Icons.videocam;
              visibleTimer = false;
              _start = '5';
            });
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
