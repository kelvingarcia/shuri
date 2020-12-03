import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/screens/signin/signin_video_mobile.dart';
import 'package:shuri/screens/signup/signup.dart';

class MenuInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/img/ShuriLogo.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: BotaoRedondo(
              icon: Icon(Icons.verified_user_sharp),
              text: 'Cadastre-se',
              fontSize: 20.0,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(
                    editar: false,
                  ),
                ),
              ),
            ),
          ),
          BotaoRedondo(
            icon: Icon(Icons.login),
            text: 'Fazer login',
            fontSize: 20.0,
            onPressed: () async {
              // Obtain a list of the available cameras on the device.
              final cameras = await availableCameras();
              // Get a specific camera from the list of available cameras.
              final firstCamera = cameras.last;
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
        ],
      ),
    );
  }
}
