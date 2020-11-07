import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/modulos/principal/componentes/SectionHeader.dart';
import 'package:chalana_delivery/modulos/principal/componentes/card_produto.dart';
import 'package:flutter/material.dart';

class SectionList extends StatelessWidget {
  List<ProdutoModelo> produtos;

  SectionList(this.produtos);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader("Bebidas"),
            SizedBox(
              height: 150,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                     return CardProduto(produtos[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(
                        height: 4,
                      ),
                  itemCount: produtos.length),
            )
          ]),
    );
  }
}
