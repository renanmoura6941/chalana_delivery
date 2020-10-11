import 'package:flutter/material.dart';

import 'produto_gerencia_widget.dart';

class QtdProdCarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 70,
      // color: Colors.red,
      child: Row(
        children: [
          GerenciaProdutoWidget(
            title: 'Quantidade: ',
            widget: Container(
              // color: Colors.amber,
              alignment: Alignment.center,
              width: 130,
              child: Row(
                children: [
                  Expanded(child: Text('--')),
                  Expanded(child: Text('1')),
                  Expanded(child: Text('+')),
                ],
              ),
            ),
          ),
          GerenciaProdutoWidget(
            title: 'Preço: ',
            alignment: Alignment.centerRight,
            widget: Container(
              // color: Colors.amber,
              width: 100,
              alignment: Alignment.centerLeft,
              child: Text('R\$ 199,99'),
            ),
          ),
        ],
      ),
    );
  }
}
