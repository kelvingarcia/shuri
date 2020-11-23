// import 'dart:html';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/models/treina_request.dart';
import 'package:shuri/screens/signup/camera_video_mobile.dart';

class CameraInfo extends StatelessWidget {
  final TreinaRequest treinaRequest;

  CameraInfo(this.treinaRequest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atenção'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Precisaremos acessar sua câmera para capturar a sua face e cadastrar em nosso banco de dados. Ao clicar no botão \'Prosseguir\', você concorda com a gravação e o armazenamento de sua imagem.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Será uma gravação de 15 segundos, clique em permitir o acesso a câmera para que seja possível concluir a gravação.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            BotaoRedondo(
              icon: Icon(Icons.arrow_forward),
              text: 'Prosseguir',
              onPressed: () async {
                // Obtain a list of the available cameras on the device.
                final cameras = await availableCameras();

                // Get a specific camera from the list of available cameras.
                final firstCamera = cameras.last;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraVideoMobile(
                      treinaRequest: treinaRequest,
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
