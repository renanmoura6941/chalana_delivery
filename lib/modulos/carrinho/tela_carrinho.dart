import 'package:chalana_delivery/modulos/carrinho/components/Card_preco.dart';
import 'package:chalana_delivery/modulos/carrinho/components/card_item.dart';
import 'package:chalana_delivery/modulos/carrinho/components/card_vazio.dart';
import 'package:chalana_delivery/modulos/carrinho/funcionalidades/carrinho_regra_negocio.dart';
import 'package:flutter/material.dart';

class TelaCarrinho extends StatefulWidget {
  @override
  _TelaCarrinhoState createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  CarrinhoRegraNegocio carrinhoRegraNegocio = CarrinhoRegraNegocio();
 @override
  void dispose() {
    print("destruir");
    carrinhoRegraNegocio.destruir();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrinho'),
        
      ),
      body: StreamBuilder<Object>(
          stream: carrinhoRegraNegocio.saidaCarrinho,
          builder: (context, snapshot) {
            return carrinhoRegraNegocio.carrinho.listaPedidos.isEmpty
                ? CardVazio(
                    iconData: Icons.remove_shopping_cart,
                    title: 'Nenhum produto no carrinho!',
                  )
                : ListView.builder(
                    itemCount:
                        carrinhoRegraNegocio.carrinho.listaPedidos.length + 1,
                    itemBuilder: (_, index) {
                      if (index ==
                          carrinhoRegraNegocio.carrinho.listaPedidos.length) {
                        if (carrinhoRegraNegocio
                            .carrinho.listaPedidos.isNotEmpty) {
                          return CardPreco(
                            carrinho: carrinhoRegraNegocio.carrinho,
                            onPressed: () async {
                              await carrinhoRegraNegocio.confirmarPedido(context);
                            },
                          );
                        }
                      }
                      return CardItem(
                          carrinhoRegra: carrinhoRegraNegocio, indice: index);
                    },
                  );
          }),
    );
  }
}
