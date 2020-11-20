import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shuri/models/treina_request.dart';
import 'package:shuri/screens/signup/signup_sucesso.dart';

class CameraVideoMobile extends StatefulWidget {
  final CameraDescription camera;
  final TreinaRequest treinaRequest;

  CameraVideoMobile({
    Key key,
    @required this.camera,
    this.treinaRequest,
  }) : super(key: key);

  @override
  _CameraVideoMobileState createState() => _CameraVideoMobileState();
}

class _CameraVideoMobileState extends State<CameraVideoMobile> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  IconData icone = Icons.videocam;
  String _start = '15';
  Timer _timer;
  bool visibleTimer = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
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
            if (int.parse(_start) < 10) {
              _start = '0' + (int.parse(_start) - 1).toString();
            } else {
              _start = (int.parse(_start) - 1).toString();
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro face'),
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
                      '00:' + _start,
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

            await Future.delayed(Duration(seconds: 15));

            await _controller.stopVideoRecording();

            var video = File(path);

            var encode = base64.encode(video.readAsBytesSync());

            widget.treinaRequest.video = encode;

            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpSucesso(widget.treinaRequest)),
            );

            setState(() {
              icone = Icons.videocam;
              visibleTimer = false;
              _start = '10';
            });
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
