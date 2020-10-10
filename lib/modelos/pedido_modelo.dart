import 'package:chalana_delivery/modelos/produto_modelo.dart';

class PedidoModelo {
  ProdutoModelo produto;
  int quantidade = 1;

  double preco() => produto.preco * quantidade;

  void incrementar() {
    quantidade++;
  }

  void decrementar() {
    quantidade--;
  }
}
