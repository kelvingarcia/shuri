import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/components/card_principal.dart';
import 'package:shuri/screens/signin/signin_video_mobile.dart';
import 'package:shuri/screens/signup/signup.dart';

class MenuInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardPrincipal(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotaoRedondo(
              icon: Icon(Icons.verified_user_sharp),
              text: 'Cadastre-se',
              fontSize: 20.0,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
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
      ),
    );
  }
}
