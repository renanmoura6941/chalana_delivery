import 'package:flutter/material.dart';

class ConfirmButtonCar extends StatelessWidget {
  final void Function() onPressed;

  const ConfirmButtonCar({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      height: 75,
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
