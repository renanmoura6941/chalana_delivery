import 'package:flutter/material.dart';

class ConfirmButtonCar extends StatelessWidget {
  final void Function() onPressed;

  const ConfirmButtonCar({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          "Confirmar",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
