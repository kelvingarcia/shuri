// import 'dart:html';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shuri/models/treina_request.dart';
import 'package:shuri/screens/signup/camera_video_mobile.dart';

class CameraInfo extends StatelessWidget {
  final TreinaRequest treinaRequest;

  CameraInfo(this.treinaRequest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Atenção',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Precisamos acessar sua câmera para capturar a sua face e cadastrar em nosso banco de dados. Ao clicar no botão \'Prosseguir\', você concorda com a gravação e o armazenamento de sua imagaem',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Será uma gravação de 10 segundos, clique em permitir o acesso a câmera para que seja possível concluir a gravação.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Colors.blue,
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
              child: Text(
                'Prosseguir',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
