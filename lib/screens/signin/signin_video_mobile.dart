import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shuri/models/reconhece_request.dart';
import 'package:shuri/models/treina_request.dart';
import 'package:shuri/screens/signin/signin_sucesso.dart';

class SignInVideoMobile extends StatefulWidget {
  final CameraDescription camera;
  TreinaRequest treinaRequest;

  SignInVideoMobile({
    Key key,
    @required this.camera,
    this.treinaRequest,
  }) : super(key: key);

  @override
  _SignInVideoMobileState createState() => _SignInVideoMobileState();
}

class _SignInVideoMobileState extends State<SignInVideoMobile> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconhecimento'),
      ),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.mp4',
            );

            // Attempt to take a picture and log where it's been saved.
            // await _controller.takePicture(path);

            await _controller.prepareForVideoRecording();

            await _controller.startVideoRecording(path);

            await Future.delayed(Duration(seconds: 5));

            await _controller.stopVideoRecording();

            var video = File(path);

            var encode = base64.encode(video.readAsBytesSync());

            var reconheceRequest = ReconheceRequest(encode);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignInSucesso(reconheceRequest)),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}
