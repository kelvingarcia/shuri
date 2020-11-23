import 'package:flutter/material.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/components/card_principal.dart';
import 'package:shuri/models/treina_request.dart';
import 'package:shuri/screens/signup/camera_info.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo usuário'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 24.0, right: 8.0, bottom: 8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  controller: _nomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Nome',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'E-mail',
                  ),
                ),
              ),
              BotaoRedondo(
                icon: Icon(Icons.arrow_forward),
                text: 'Prosseguir',
                onPressed: () {
                  var treinaRequest = TreinaRequest(
                      nome: _nomeController.text, email: _emailController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraInfo(treinaRequest),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
