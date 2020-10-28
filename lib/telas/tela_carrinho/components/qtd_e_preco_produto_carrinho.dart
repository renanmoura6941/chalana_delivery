import 'package:flutter/material.dart';

import 'contador_widget.dart';

class QtdEPrecoProdutoCarrinho extends StatefulWidget {
  final double preco;
  final void Function(int) onChange;

  const QtdEPrecoProdutoCarrinho({Key key, this.preco, this.onChange})
      : super(key: key);

  @override
  _QtdEPrecoProdutoCarrinhoState createState() =>
      _QtdEPrecoProdutoCarrinhoState();
}

class _QtdEPrecoProdutoCarrinhoState extends State<QtdEPrecoProdutoCarrinho> {
  int _current_qtd = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      // color: Colors.red,
      child: Row(
        children: [
          Expanded(
            child: Container(
              // color: Colors.purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Quantidade: '),
                  Expanded(
                    child: ContadorButton(
                      qtd_produto: _current_qtd,
                      onTap: (newQtd) {
                        setState(() {
                          _current_qtd = newQtd;
                          widget.onChange(_current_qtd);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.amber,
              alignment: Alignment.bottomRight,
              height: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  // "R\$: 1000000000000000000000000000000",
                  "R\$: ${(widget.preco * _current_qtd).toStringAsFixed(2)}",
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
