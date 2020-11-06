import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modelos/pedido_modelo.dart';

class ControllerCarriho {
  List<PedidoModelo> list_pedidos = [];

  double get total {
    double total = 0;
    for (var e in list_pedidos) total += e.quantidade * e.produto.preco;
    return total;
  }

  Future<void> confirmarPedido() async {
    String q = "%0A";
    String divisor = "------------------------------------";
    double total = 0;
    String mensagem = "Minha solicitação:$q";

    for (var e in list_pedidos) {
      mensagem +=
          "$divisor$q*Produto*: ${e.produto.nome}$q*Quantidade*: ${e.quantidade}$q*Preço da unidade*: R\$ ${e.produto.preco.toStringAsFixed(2)}$q*Valor*: R\$ ${(e.quantidade * e.produto.preco).toStringAsFixed(2)}$q";
      total += e.quantidade * e.produto.preco;
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
      //TODO:limpar carrinho
    } catch (erro) {
      debugPrint("erro ao enviar mensagem: $erro");
    }
  }
}
