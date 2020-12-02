import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shuri/components/botao_redondo.dart';
import 'package:shuri/http/webclients/treina_mobileclient.dart';
import 'package:shuri/models/pasta_dto.dart';

class NovaPasta extends StatefulWidget {
  final String id;

  const NovaPasta({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _NovaPastaState createState() => _NovaPastaState();
}

class _NovaPastaState extends State<NovaPasta> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usuariosController = TextEditingController();
  final TextEditingController _pastaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  List<String> _usuarios = List();
  Widget botaoAdd = Icon(Icons.add_circle);
  bool erro = false;

  @override
  void initState() {
    debugPrint('entrou no init State');
    super.initState();
    if (widget.id != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
        var pastaModel = await TreinaMobileClient.getUmaPasta(widget.id);
        setState(() {
          _pastaController.text = pastaModel.nomePasta;
          _descricaoController.text = pastaModel.descricao;
          _usuarios = pastaModel.membros;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Nova pasta'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 48.0, bottom: 8.0),
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
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        padding: const EdgeInsets.only(left: 24.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              botaoAdd = CircularProgressIndicator();
                            });
                            var pessoa = await TreinaMobileClient.buscaPorEmail(
                                _usuariosController.text);
                            if (pessoa != null) {
                              setState(() {
                                botaoAdd = Icon(Icons.add_circle);
                                _usuarios.add(_usuariosController.text);
                                _usuariosController.text = '';
                              });
                            } else {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('E-mail não encontrado'),
                                ),
                              );
                              setState(() {
                                botaoAdd = Icon(Icons.add_circle);
                                erro = true;
                              });
                            }
                          },
                          child: Center(
                            child: botaoAdd,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _usuarios.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              _usuarios[index],
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: BotaoRedondo(
                  icon: Icon(Icons.done),
                  text: 'Criar pasta',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
