import 'package:flutter/material.dart';

import 'contador_widget.dart';

class GerenciarProdCar extends StatefulWidget {
  final double preco;
  final void Function(int) onChange;

  const GerenciarProdCar({Key key, this.preco, this.onChange})
      : super(key: key);

  @override
  _GerenciarProdCarState createState() => _GerenciarProdCarState();
}

class _GerenciarProdCarState extends State<GerenciarProdCar> {
  int _current_qtd = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
              alignment: Alignment.bottomRight,
              height: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
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
