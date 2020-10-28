import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/telas/tela_carrinho/components/descricao_produto_carrinho.dart';
import 'package:flutter/material.dart';
import 'qtd_e_preco_produto_carrinho.dart';

class CardProdutoCarrinho extends StatelessWidget {
  final PedidoModelo pedido;

  const CardProdutoCarrinho({Key key, this.pedido}) : super(key: key);

  // final String nome_produto;
  // final String imagem;
  // final double preco;

  // const CardProdutoCarrinho(
  //     {Key key, this.nome_produto, this.imagem, this.preco})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.red,
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DescricaoProdutoCarrinho(
            produto: pedido.produto,
          ),
          QtdEPrecoProdutoCarrinho(
            preco: pedido.produto.preco,
            onChange: (qtd) {
              pedido.quantidade = qtd;
              // print(pedido.quantidade);
            },
          ),
        ],
      ),
    );
  }
}
