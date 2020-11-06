import 'package:flutter/material.dart';

popAlerta(BuildContext context, String mensagem) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            title: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(mensagem)),
          ));
}
