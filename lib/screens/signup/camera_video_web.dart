// import 'dart:convert';
// import 'dart:html';
// import 'dart:js';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:shuri/models/treina_request.dart';
// import 'package:shuri/screens/signup/signup_sucesso.dart';

// class CameraVideoWeb extends StatefulWidget {
//   TreinaRequest treinaRequest;

//   CameraVideoWeb(this.treinaRequest);

//   @override
//   _CameraVideoWebState createState() => _CameraVideoWebState();
// }

// class _CameraVideoWebState extends State<CameraVideoWeb> {
//   Widget _webcamWidget;
//   VideoElement _webcamVideoElement;

//   @override
//   void initState() {
//     super.initState();
//     _webcamVideoElement = VideoElement();
//     // Register an webcam
//     ui.platformViewRegistry.registerViewFactory(
//         'webcamVideoElement', (int viewId) => _webcamVideoElement);
//     // Create video widget
//     _webcamWidget =
//         HtmlElementView(key: UniqueKey(), viewType: 'webcamVideoElement');
//     // Access the webcam stream
//     window.navigator.getUserMedia(video: true).then((MediaStream stream) {
//       _webcamVideoElement.srcObject = stream;
//     });
//     WidgetsBinding.instance
//         .addPostFrameCallback((_) => _webcamVideoElement.play());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: 750,
//           height: 750,
//           child: _webcamWidget,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.camera_alt),
//         onPressed: () {
//           List<Blob> listaBlob = List();
//           var captureStream = _webcamVideoElement.captureStream();
//           var options = {'mimeType': 'video/webm;codecs=vp9'};
//           var mediaRecorder = MediaRecorder(captureStream, options);
//           mediaRecorder.addEventListener('dataavailable', (event) {
//             print("datavailable ${event.runtimeType}");
//             final Blob blob = JsObject.fromBrowserObject(event)['data'];
//             listaBlob.add(blob);
//           });
//           mediaRecorder.start(5);
//           Future.delayed(Duration(seconds: 15), () {
//             _webcamVideoElement.pause();
//             mediaRecorder.stop();
//             Future.delayed(Duration(seconds: 5), () {
//               var video = Blob(listaBlob, 'video/webm');
//               print("Blob size: ${video.size}");
//               var reader = FileReader();
//               reader.onLoad.listen((e) {
//                 _handleData(reader, context);
//               });
//               reader.readAsArrayBuffer(video);
//             });
//           });
//         },
//       ),
//     );
//   }

//   void _handleData(FileReader reader, BuildContext context) {
//     Uint8List uintlist = new Uint8List.fromList(reader.result);
//     var encode = base64.encode(uintlist);
//     widget.treinaRequest.video = encode;
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => SignUpSucesso(widget.treinaRequest)));
//   }
// }
