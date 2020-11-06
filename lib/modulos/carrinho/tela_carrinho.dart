import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modulos/carrinho/components/Card_preco.dart';
import 'package:chalana_delivery/modulos/carrinho/components/card_item.dart';
import 'package:chalana_delivery/modulos/carrinho/components/card_vazio.dart';
import 'package:chalana_delivery/modulos/carrinho/controller_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
      controller.list_pedidos = GetIt.I.get<List<PedidoModelo>>();
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
      body: controller.list_pedidos.isEmpty
          ? CardVazio(
              iconData: Icons.remove_shopping_cart,
              title: 'Nenhum produto no carrinho!',
            )
          : ListView.builder(
              itemCount: controller.list_pedidos.length + 1,
              itemBuilder: (_, index) {
                if (index == controller.list_pedidos.length) {
                  return CardPreco(
                    carrinho: controller,
                    onPressed: () async {
                      await controller.confirmarPedido();
                    },
                  );
                }
                return CardItem(
                  pedido: controller.list_pedidos[index],
                  onPressed: () {
                    setState(() {
                      controller.list_pedidos.removeAt(index);
                    });
                  },
             
                );
              },
            ),
    );
  }
}
