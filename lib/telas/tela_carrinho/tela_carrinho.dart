import 'package:flutter/material.dart';

import 'components/produto_carrinho_widget.dart';
import 'components/qtd_prod_car_widget.dart';
import 'constants.dart';

class TelaCarrinho extends StatefulWidget {
  @override
  _TelaCarrinhoState createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrinho'),
      ),
      body: Card(
        // color: Colors.red,
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProdutoCarrinhoWidget(
              imagem: IMG,
              nome: "Nome do produto",
            ),
            QtdProdCarWidget(),
          ],
        ),
      ),
    );
  }
}
