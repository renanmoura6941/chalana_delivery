import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/telas/tela_carrinho/components/descricao_produto_carrinho.dart';
import 'package:flutter/material.dart';
import 'gerenciar_pedido_carrinho.dart';

class CardProdutoCarrinho extends StatelessWidget {
  final PedidoModelo pedido;

  const CardProdutoCarrinho({Key key, this.pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DescricaoProdutoCarrinho(
            produto: pedido.produto,
          ),
          GerenciarProdCar(
            pedido: pedido,
          ),
        ],
      ),
    );
  }
}
