import 'package:flutter/material.dart';
import 'package:shuri/screens/menu_inicial.dart';
import 'package:shuri/screens/pastas/documentos.dart';
import 'package:shuri/screens/sucesso/tela_sucesso.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 150, 0, 1),
        accentColor: Color.fromRGBO(255, 150, 0, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuInicial(),
    );
  }
}
