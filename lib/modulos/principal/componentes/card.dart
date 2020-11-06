import 'package:chalana_delivery/helpers/tratamento_erros.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardPrincipal extends StatelessWidget {
  ProdutoModelo produtoModelo;
  CardPrincipal(this.produtoModelo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Principal");
        print("produto: ${produtoModelo.hashCode}");
        print("produto imagem: ${produtoModelo.imagens.hashCode}");
        Navigator.pushNamed(context, "produto", arguments: produtoModelo.copiar());
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.7,
              child: produtoModelo.imagens.isEmpty
                  ? ERRO_SEM_FOTO
                  : produtoModelo.imagens.first.url != null
                      ? Image.network(produtoModelo.imagens.first.url,
                          loadingBuilder: (BuildContext context, Widget child,
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
                        })
                      : ERRO_SEM_FOTO,
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
