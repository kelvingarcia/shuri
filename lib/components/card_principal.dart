import 'package:flutter/material.dart';

class CardPrincipal extends StatelessWidget {
  final Widget child;

  CardPrincipal({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 190, 74, 0.8),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.1,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: child,
        ),
      ),
    );
  }
}
