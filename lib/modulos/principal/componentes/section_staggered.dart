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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            color: Colors.white,
          ),
          SectionHeader("Produtos"),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: produtos.length,
              itemBuilder: (_, indice) {
                return CardProduto(produtos[indice]);
              },

              // GridView.builder(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       childAspectRatio: 1,
              //       crossAxisSpacing: 0,
              //       mainAxisSpacing: 0),
              //   padding: EdgeInsets.zero,
              //   shrinkWrap: true,
              //   itemCount: produtos.length,
              //   physics:
              //       BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              //   itemBuilder: (_, index) {
              //     return CardProduto(produtos[index]);
              //   },
              // )
              // StaggeredGridView.countBuilder(
              //   padding: EdgeInsets.zero,
              //   shrinkWrap: true,
              //   crossAxisCount: 4,
              //   itemCount: produtos.length,
              //   physics:
              //       BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              //   itemBuilder: (_, index) {
              //     return CardProduto(produtos[index]);
              //   },
              //   staggeredTileBuilder: (index) =>
              //       StaggeredTile.count(2, index.isEven ? 2 : 1),
              //   mainAxisSpacing: 4,
              //   crossAxisSpacing: 4,
              // )
            ),
          ),
        ],
      ),
    );
  }
}
