import 'package:flutter/material.dart';

import 'qtd_widget_button.dart';

class ContadorButton extends StatelessWidget {
  final int qtd_produto;
  final void Function(int qtd) onTap;

  const ContadorButton({Key key, this.qtd_produto = 1, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.cyan,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          QtdWidgetButton(
            onTap: () {
              if (qtd_produto > 1) {
                onTap(qtd_produto - 1);
              }
            },
            child: Text(
              '−',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text("$qtd_produto"),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
          ),
          QtdWidgetButton(
            onTap: () {
              onTap(qtd_produto + 1);
            },
            child: Text(
              '+',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
