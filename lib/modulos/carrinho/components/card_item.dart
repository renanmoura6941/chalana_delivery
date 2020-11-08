import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modulos/carrinho/components/icone_custumizado.dart';
import 'package:chalana_delivery/modulos/carrinho/funcionalidades/carrinho_regra_negocio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardItem extends StatefulWidget {
  CarrinhoRegraNegocio carrinhoRegra;
  int indice;
  Function onPressed;

  CardItem({this.carrinhoRegra, this.indice, this.onPressed});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    PedidoModelo pedido =
        widget.carrinhoRegra.carrinho.listaPedidos[widget.indice];

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
                  child: CachedNetworkImage(
                    imageUrl: pedido.produto.imagens.first.url,
                    placeholder: (context, url) => CARREGANDO2,
                    errorWidget: (context, url, error) =>
                        Center(child: ERRO_IMAGEM),
                  )),
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
                        'R\$ ${pedido.preco().toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: COR_PRINCIPAL),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  IconeCustumizado(
                      iconData: Icons.add,
                      color: COR_PRINCIPAL,
                      onTap: () {
                        setState(() {
                          widget.carrinhoRegra.incrementar(widget.indice);
                        });
                      }),
                  Text(
                    '${pedido.quantidade}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  pedido.quantidade == 1
                      ? RaisedButton(
                          color: Colors.red,
                          onPressed: () {
                            widget.carrinhoRegra.removerPedido(widget.indice);
                          },
                          child: Text("Remover"),
                        )
                      : IconeCustumizado(
                          iconData: Icons.remove,
                          color: COR_PRINCIPAL,
                          onTap: () {
                            setState(() {
                              widget.carrinhoRegra.decrementar(widget.indice);
                            });
                          }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
