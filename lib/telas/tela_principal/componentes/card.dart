import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';

class CardPrincipal extends StatelessWidget {
  ProdutoModelo produtoModelo;
  CardPrincipal(this.produtoModelo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "produto", arguments: produtoModelo);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.7,
              child: Image.network(produtoModelo.imagens.first, loadingBuilder:
                  (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              }),
            ),
            Container(
              color: Colors.transparent,
              child: Text(produtoModelo.nome,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            Text(
              "R\$ " + produtoModelo.preco.toStringAsFixed(2),
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
