import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modulos/carrinho/components/descricao_produto_carrinho.dart';
import 'package:flutter/material.dart';
import 'gerenciar_pedido_carrinho.dart';

class CardProdutoCarrinho extends StatelessWidget {
  final PedidoModelo pedido;
  final void Function() onPressed;

  const CardProdutoCarrinho({Key key, this.pedido, this.onPressed})
      : super(key: key);

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
          Container(
            height: 50,
            margin: EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Container(
              height: double.infinity,
              child: RaisedButton(
                onPressed: onPressed,
                color: Colors.red,
                textColor: Colors.white,
                child: Text("Remover item"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
