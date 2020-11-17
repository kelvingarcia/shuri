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
  String _start = '10';
  Timer _timer;

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
            _start = '0' + (int.parse(_start) - 1).toString();
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
          Positioned(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(icone),
        onPressed: () async {
          setState(() {
            icone = Icons.close;
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

            await Future.delayed(Duration(seconds: 10));

            await _controller.stopVideoRecording();

            var video = File(path);

            var encode = base64.encode(video.readAsBytesSync());

            widget.treinaRequest.video = encode;

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpSucesso(widget.treinaRequest)),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
