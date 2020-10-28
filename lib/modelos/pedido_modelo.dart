import 'package:chalana_delivery/modelos/produto_modelo.dart';

class PedidoModelo {
  final ProdutoModelo produto;
  int quantidade;

  PedidoModelo({this.produto, this.quantidade = 1});

  double preco() => produto.preco * quantidade;
}
