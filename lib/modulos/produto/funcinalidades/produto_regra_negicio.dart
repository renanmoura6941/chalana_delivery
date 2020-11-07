import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:get_it/get_it.dart';

class PeodutoRegraNegocio {
  bool noCarrinho;

  estaNoCarrinho(ProdutoModelo produto) {
    var carrinho = GetIt.I.get<List<PedidoModelo>>();
    noCarrinho = false;
    carrinho.forEach((e) {
      if (e.produto.id == produto.id) {
        noCarrinho = true;
      }
    });
    print("produto esta no carrinho: $noCarrinho");
  }

  addCarrinho(ProdutoModelo produto) {
    var carrinho = GetIt.I.get<List<PedidoModelo>>();
    carrinho.add(PedidoModelo(produto: produto));
  }
}
