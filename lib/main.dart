import 'package:flutter/material.dart';
import 'package:shuri/screens/pastas/pagina_inicial.dart';

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
      home: PaginaInicial(),
    );
  }
}
