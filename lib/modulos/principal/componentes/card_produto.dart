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
        onTap: () => Navigator.pushNamed(context, "produto",
            arguments: produto.copiar()),
        child: produto.imagens.first.url == null
            ? ERRO_IMAGEM
            : CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: produto.imagens.first.url,
                placeholder: (context, url) => CARREGANDO,
                errorWidget: (context, url, error) =>
                    Center(child: ERRO_IMAGEM),
              ));
  }
}
