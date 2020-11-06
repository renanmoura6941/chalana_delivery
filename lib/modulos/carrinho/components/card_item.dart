import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modulos/carrinho/components/icone_custumizado.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  PedidoModelo pedido;
  void Function() onPressed;
 
  void Function() estado;

  CardItem({this.pedido, this.onPressed, this.estado});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(widget.pedido.produto.imagens.first.url),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.pedido.produto.nome,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'A partir de',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        'R\$ ${widget.pedido.preco()}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColor),
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
                      onTap: () {
                        setState(() {
                          widget.pedido.quantidade++;
                        });
                        widget.estado;
                      }),
                  Text(
                    '${widget.pedido.quantidade}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconeCustumizado(
                    iconData: Icons.remove,
                    color: widget.pedido.quantidade > 1
                        ? Theme.of(context).primaryColor
                        : Colors.red,
                    onTap: () {
                      setState(() {
                        widget.pedido.quantidade--;
                      });
                      widget.estado;
                    },
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
