import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';

class DescricaoProdutoCarrinho extends StatelessWidget {
  final ProdutoModelo produto;

  const DescricaoProdutoCarrinho({Key key, this.produto}) : super(key: key);

  // final String imagem;
  // final String nome_produto;

  // const DescricaoProdutoCarrinho({Key key, this.imagem, this.nome_produto})
  //     : super(key: key);
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
                produto.imagens[0],
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Text(
              produto.nome,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
