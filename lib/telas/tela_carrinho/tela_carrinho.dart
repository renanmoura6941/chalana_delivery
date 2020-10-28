import 'package:chalana_delivery/modelos/pedido_modelo.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
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
                    onPressed: () async {
                      print("Confirmar pedido");
                      var produto = {
                        'nome': "Cerveja da boa",
                        'quantidade': 4,
                        'unidade': 2.00,
                        'valor': 8.00
                      };
                      var produto2 = {
                        'nome': "vinho especial",
                        'quantidade': 10,
                        'unidade': 2.00,
                        'valor': 20.00
                      };

                      List<Map> dados = [produto, produto2];

                      String q = "%0A";
                      String divisor = "------------------------------------";
                      double total = 0;
                      String mensagem = "Minha solicitação:$q";
                      for (var e in dados) {
                        mensagem +=
                            "$divisor$q*Produto*: ${e['nome']}$q*Quantidade*: ${e['quantidade']}$q*Preço da unidade*: R\$ ${e['unidade'].toStringAsFixed(2)}$q*Valor*: R\$ ${e['valor'].toStringAsFixed(2)}$q";
                        total += e['valor'];
                      }

                      mensagem += divisor +
                          q +
                          q +
                          q +
                          "*Preço total da solicitação*: ${total.toStringAsFixed(2)}";

                      String url =
                          "https://api.whatsapp.com/send/?phone=5585992954232&text=${mensagem}&app_absent=0";

                      try {
                        await launch(url);
                      } catch (erro) {
                        debugPrint("erro ao enviar mensagem: $erro");
                      }
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
