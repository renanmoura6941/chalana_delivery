import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/telas/tela_carrinho/controller_carrinho.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'components/card_produto_carrinho.dart';
import 'components/confirm_button_carrinho.dart';

class TelaCarrinho extends StatefulWidget {
  @override
  _TelaCarrinhoState createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  final controller = ControllerCarriho();

  @override
  void initState() {
    setState(() {
      controller.list_produto = GetIt.I.get<List<PedidoModelo>>();
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
      body: controller.list_produto.isEmpty
          ? Center(
              child: Text(
                "Lista vazia!",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          : ListView.builder(
              itemCount: controller.list_produto.length + 1,
              itemBuilder: (_, index) {
                if (index == controller.list_produto.length) {
                  return ConfirmButtonCar(
                    onPressed: () async {
                      await controller.confirmarPedido();
                    },
                  );
                }
                return CardProdutoCarrinho(
                  pedido: controller.list_produto[index],
                  onPressed: () {
                    setState(() {
                      controller.list_produto.removeAt(index);
                    });
                  },
                );
              },
            ),
    );
  }
}
