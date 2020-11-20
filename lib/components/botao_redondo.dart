import 'package:flutter/material.dart';

class BotaoRedondo extends StatelessWidget {
  final Function onPressed;
  final Icon icon;
  final String text;
  final double fontSize;

  BotaoRedondo({
    @required this.icon,
    @required this.text,
    @required this.onPressed,
    this.fontSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.1,
          ),
        ),
        textColor: Colors.white,
        color: Theme.of(context).accentColor,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
