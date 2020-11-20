import 'package:flutter/material.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/screens/configuracoes/configuracoes.dart';
import 'package:shuri/screens/menu_inicial.dart';
import 'package:shuri/screens/notificacoes/notificacoes.dart';
import 'package:shuri/screens/pastas/pagina_inicial.dart';
import 'package:shuri/screens/signup/signup_sucesso.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuInicial(),
    );
  }
}
