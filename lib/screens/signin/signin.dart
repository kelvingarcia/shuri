import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shuri/screens/signin/signin_video_mobile.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Sign In'),
          onPressed: () async {
            // Obtain a list of the available cameras on the device.
            final cameras = await availableCameras();

            // Get a specific camera from the list of available cameras.
            final firstCamera = cameras.first;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInVideoMobile(
                  camera: firstCamera,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
