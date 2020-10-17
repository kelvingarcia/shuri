import 'package:flutter/material.dart';

class Pasta extends StatelessWidget {
  final String nomePasta;
  final String descricao;
  final Function onPressed;
  final bool divider;

  Pasta({
    @required this.nomePasta,
    @required this.onPressed,
    @required this.descricao,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.folder,
                  size: 64.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nomePasta,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(descricao),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: divider,
              child: Divider(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
