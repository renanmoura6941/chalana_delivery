import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/modulos/principal/componentes/secao.dart';
import 'package:chalana_delivery/modulos/principal/componentes/card_produto.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecaoGrade extends StatelessWidget {
  List<ProdutoModelo> produtos;

  SecaoGrade(this.produtos);

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
          Secao("Produtos"),
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
            ),
          ),
        ],
      ),
    );
  }
}
