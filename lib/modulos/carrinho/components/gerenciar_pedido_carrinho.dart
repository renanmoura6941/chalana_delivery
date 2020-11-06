import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:flutter/material.dart';

import 'contador_widget.dart';

class GerenciarProdCar extends StatefulWidget {
  final PedidoModelo pedido;

  const GerenciarProdCar({
    Key key,
    this.pedido,
  }) : super(key: key);

  @override
  _GerenciarProdCarState createState() => _GerenciarProdCarState();
}

class _GerenciarProdCarState extends State<GerenciarProdCar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: ContadorButton(
              qtd_produto: widget.pedido.quantidade,
              onTap: (newQtd) {
                setState(() {
                  widget.pedido.quantidade = newQtd;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              height: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "R\$: ${(widget.pedido.produto.preco * widget.pedido.quantidade).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
