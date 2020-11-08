import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> temInternet() async {
  String url = "http://www.google.com.br";
  http.Response resposta;

  try {
    resposta =
        await http.get(url).timeout(Duration(seconds: 3)).catchError((erro) {
      print("desconectado ERRO $erro");
      return false;
    });
  } catch (erro) {
    print("desconectado ERRO $erro");
    return false;
  }

  if (resposta.statusCode == 200) {
    print("Conectado");
    return true;
  }

  debugPrint("desconectado");
  return false;
}
