import 'package:chalana_delivery/telas/tela_carrinho/mock/pedidos_mock.dart';
import 'package:flutter/material.dart';
import 'components/card_produto_carrinho.dart';

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
      body: ListView.builder(
        itemCount: MockCarrinho.pedidos_mock.length,
        itemBuilder: (_, index) {
          return CardProdutoCarrinho(
            pedido: MockCarrinho.pedidos_mock[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MockCarrinho.pedidos_mock.forEach((element) {
            print(element.preco());
          });
        },
      ),
    );
  }
}
