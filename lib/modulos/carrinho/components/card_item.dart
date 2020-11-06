import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modulos/carrinho/components/icone_custumizado.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  PedidoModelo pedido;
  void Function() onPressed;

  CardItem({this.pedido, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(pedido.produto.imagens.first.url),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        pedido.produto.nome,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  IconeCustumizado(
                    iconData: Icons.add,
                    color: Theme.of(context).primaryColor,
                    //  onTap: cartProduct.increment,
                  ),
                  Text(
                    '${pedido.quantidade}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconeCustumizado(
                    iconData: Icons.remove,
                    color: pedido.quantidade > 1
                        ? Theme.of(context).primaryColor
                        : Colors.red,
                    //  onTap: cartProduct.decrement,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
