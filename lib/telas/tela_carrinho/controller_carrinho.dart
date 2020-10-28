import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modelos/pedido_modelo.dart';

class ControllerCarriho {
  List<PedidoModelo> list_pedidos = [];

  Future<void> confirmarPedido() async {
    print("Confirmar pedido");
    var produto = {
      'nome': "Cerveja da boa",
      'quantidade': 4,
      'unidade': 2.00,
      'valor': 8.00
    };
    var produto2 = {
      'nome': "vinho especial",
      'quantidade': 10,
      'unidade': 2.00,
      'valor': 20.00
    };

    List<Map> dados = [produto, produto2];

    String q = "%0A";
    String divisor = "------------------------------------";
    double total = 0;
    String mensagem = "Minha solicitação:$q";
    for (var e in dados) {
      mensagem +=
          "$divisor$q*Produto*: ${e['nome']}$q*Quantidade*: ${e['quantidade']}$q*Preço da unidade*: R\$ ${e['unidade'].toStringAsFixed(2)}$q*Valor*: R\$ ${e['valor'].toStringAsFixed(2)}$q";
      total += e['valor'];
    }

    mensagem += divisor +
        q +
        q +
        q +
        "*Preço total da solicitação*: ${total.toStringAsFixed(2)}";

    String url =
        "https://api.whatsapp.com/send/?phone=5585992954232&text=${mensagem}&app_absent=0";

    try {
      await launch(url);
    } catch (erro) {
      debugPrint("erro ao enviar mensagem: $erro");
    }
  }
}
