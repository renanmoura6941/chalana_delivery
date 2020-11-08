import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

whatsAppMensagem() async {
  String mensagem = "Eu+tenho%0A%0A%0A+interesse+no+seu+carro+%C3%A0+venda";

  String url =
      "https://api.whatsapp.com/send/?phone=5585992818078&text=${mensagem}&app_absent=0";

  http.Response resposta = await http.post(url);

  if (resposta.statusCode == 200) {
  } else {
    debugPrint("erro ao enviar mensagem para o whatsApp");
  }
}

