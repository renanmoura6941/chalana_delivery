import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardProduto extends StatelessWidget {
  ProdutoModelo produto;
  CardProduto(this.produto);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "produto", arguments: produto.copiar());
        },
        // child: Card(
        //   // margin: const EdgeInsets.symmetric(horizontal:16, vertical: 4),
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        //   child: Container(
        //     // height: 100,
        //     //padding: const EdgeInsets.all(1),
        //     child: Stack(
        //       children: <Widget>[

        // child: AspectRatio(
        //     aspectRatio: 1,
        child: produto.imagens.first.url == null
            ? ERRO_IMAGEM
            : CachedNetworkImage(
              fit: BoxFit.fill,
                imageUrl: produto.imagens.first.url,
                placeholder: (context, url) => CARREGANDO,
                errorWidget: (context, url, error) =>
                    Center(child: ERRO_IMAGEM),
              )
        //),

        // Positioned(
        //   width: 200,
        //   bottom: 1,
        //   child: Container(
        //     width: double.infinity,
        //     color: Colors.white,
        //     child: Text(
        //       produtoModelo.nome,
        //       style: TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.w800,
        //       ),
        //     ),
        //   ),
        // )

        //   ],
        // ),
        // ),
        //  ),
        );
  }
}
