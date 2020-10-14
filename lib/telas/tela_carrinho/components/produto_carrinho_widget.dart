import 'package:flutter/material.dart';

class ProdutoCarrinhoWidget extends StatelessWidget {
  final String imagem;
  final String nome;

  const ProdutoCarrinhoWidget({Key key, this.imagem, this.nome})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      // color: Colors.amber,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 0.80,
            child: Container(
              // color: Colors.cyan,
              child: Image.network(
                imagem,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Text(nome),
          ),
        ],
      ),
    );
  }
}
