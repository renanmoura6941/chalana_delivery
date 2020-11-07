import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:get_it/get_it.dart';

class CarrinhoModelo {
  List<PedidoModelo> listaPedidos;

  CarrinhoModelo() {
    listaPedidos = GetIt.I.get<List<PedidoModelo>>();
  }

   double get total {
    double soma = 0;
    for (final pedido in listaPedidos) soma += pedido.preco();
    return soma;
  }

  

}
