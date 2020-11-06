import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButaoConfirmar extends StatelessWidget {
  String titulo;
  Color cor;
  Function onPressed;
  ButaoConfirmar({this.titulo, this.cor, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: RaisedButton(
        color: cor??Colors.grey,
        child: Text(
          titulo,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
