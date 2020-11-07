import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/modulos/principal/componentes/SectionHeader.dart';
import 'package:chalana_delivery/modulos/principal/componentes/card_produto.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SectionStaggered extends StatelessWidget {
  List<ProdutoModelo> produtos;

  SectionStaggered(this.produtos);

  @override
  Widget build(BuildContext context) {
    return Container(
    
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: Colors.white,
          ),
          SectionHeader("produtos"),
          Divider(
            color: Colors.white,
          ),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: produtos.length,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (_, index) {
              return CardProduto(produtos[index]);
            },
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          )
        ],
      ),
    );
  }
}
