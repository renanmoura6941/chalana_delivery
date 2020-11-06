import 'package:chalana_delivery/modelos/produto_modelo.dart';

class PedidoModelo {
  final ProdutoModelo produto;
  int _quantidade = 1;

  PedidoModelo({this.produto});
  int get quantidade => this._quantidade;

  set quantidade(int valor) {
    if (valor > 0) {
      this._quantidade = valor;
    }
  }

  double preco() => produto.preco * quantidade;
}
