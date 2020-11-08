import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

// ignore: must_be_immutable
class CardProduto extends StatelessWidget {
  ProdutoModelo produtoModelo;
  CardProduto(this.produtoModelo);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "produto",
            arguments: produtoModelo.copiar());
      },
      // child: Card(
      //   // margin: const EdgeInsets.symmetric(horizontal:16, vertical: 4),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      //   child: Container(
      //     // height: 100,
      //     //padding: const EdgeInsets.all(1),
      //     child: Stack(
      //       children: <Widget>[

      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          image: produtoModelo.imagens.first.url,
          placeholder: kTransparentImage,
          fit: BoxFit.fill,
          imageErrorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            // Appropriate logging or analytics, e.g.
            // myAnalytics.recordError(
            //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
            //   exception,
            //   stackTrace,
            // );
            return ERRO_IMAGEM;
          },
        ),
      ),

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
