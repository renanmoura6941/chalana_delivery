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

const CARREGANDO2 = SpinKitWave(
    color: const Color.fromARGB(255, 4, 125, 141), type: SpinKitWaveType.end);

const COR_PRINCIPAL = const Color.fromARGB(255, 4, 125, 141);

const QUALIDADE = 60;

Widget ERRO_IMAGEM = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Icon(
      Icons.image_not_supported,
      color: Colors.red,
      size: 50,
    ),
    Text(
      "Sem Imagem",
      style: TextStyle(fontSize: 10),
    )
  ],
);
