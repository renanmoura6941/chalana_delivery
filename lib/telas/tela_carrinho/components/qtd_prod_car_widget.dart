import 'package:chalana_delivery/telas/tela_carrinho/components/contador_widget.dart';
import 'package:flutter/material.dart';

class QtdProdCarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 70,
      // color: Colors.red,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantidade: '),
                Expanded(
                  child: CobtadorWidget(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                // color: Colors.amber,
                ),
          ),
        ],
      ),
    );
  }
}
