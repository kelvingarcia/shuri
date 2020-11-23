import 'package:flutter/material.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/screens/menu_inicial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TreinaMobileClient.reconhecePessoaTeste();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shuri',
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuInicial(),
    );
  }
}
