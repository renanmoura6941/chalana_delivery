import 'package:chalana_delivery/modelos/pedido_modelo.dart';

class CarrinhoModelo {
  final List<PedidoModelo> listaPedidos = [];

  void adicionar(PedidoModelo pedido) {
    listaPedidos.add(pedido);
  }

  void remover(int index) {
    listaPedidos.removeAt(index);
  }

  double total() {
    double soma = 0;

    for (final pedido in listaPedidos) {
      soma += pedido.preco();
    }

    return soma;
  }
}
