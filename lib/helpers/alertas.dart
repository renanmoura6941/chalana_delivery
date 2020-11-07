import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

const CARREGANDO =
    SpinKitWave(color: Colors.white54, type: SpinKitWaveType.end);
