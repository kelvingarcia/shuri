import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  final IconData icone;
  final BorderSide borda;
  final String texto;

  const ItemMenu({
    Key key,
    this.icone,
    this.borda,
    this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: borda,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  icone,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  texto,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
