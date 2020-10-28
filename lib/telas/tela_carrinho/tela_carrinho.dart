import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'components/card_produto_carrinho.dart';
import 'components/confirm_button_carrinho.dart';

class TelaCarrinho extends StatefulWidget {
  @override
  _TelaCarrinhoState createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  List<PedidoModelo> list_produto = [];

  @override
  void initState() {
    setState(() {
      list_produto = GetIt.I.get<List<PedidoModelo>>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrinho'),
      ),
      body: list_produto.isEmpty
          ? Center(
              child: Text(
                "Lista vazia!",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          : ListView.builder(
              itemCount: list_produto.length + 1,
              itemBuilder: (_, index) {
                if (index == list_produto.length) {
                  return ConfirmButtonCar(
                    onPressed: () {
                      print("Confirmar pedido");
                    },
                  );
                }
                return CardProdutoCarrinho(
                  pedido: list_produto[index],
                );
              },
            ),
    );
  }
}
