import 'package:flutter/material.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/pasta_dto.dart';

class NovaPasta extends StatefulWidget {
  @override
  _NovaPastaState createState() => _NovaPastaState();
}

class _NovaPastaState extends State<NovaPasta> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usuariosController = TextEditingController();
  final TextEditingController _pastaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  List<String> _usuarios = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova pasta'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Cadastro'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _pastaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Nome da pasta',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Descrição',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            controller: _usuariosController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Participantes',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FlatButton(
                            onPressed: () async {
                              setState(() {
                                _usuarios.add(_usuariosController.text);
                                _usuariosController.text = '';
                              });
                            },
                            child: Text('ADD'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _usuarios.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _usuarios[index],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    var pastaResponse = await TreinaMobileClient.criaNovaPasta(
                      PastaDTO(
                        _pastaController.text,
                        _descricaoController.text,
                        _usuarios,
                      ),
                    );
                    debugPrint(pastaResponse.toString());
                    Navigator.pop(context);
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
          ),
        ),
      ),
    );
  }
}
