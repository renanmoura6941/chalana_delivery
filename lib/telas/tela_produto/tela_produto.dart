import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaProduto extends StatelessWidget {
  ProdutoModelo produtoModelo;
  TelaProduto(this.produtoModelo);

  temPedido(List<PedidoModelo> listaPedidos) {
    bool temPedido = false;
    listaPedidos.firstWhere((e) {
      if (e.produto.id == produtoModelo.id) {
        temPedido = true;
      }
    }, orElse: () {
      return null;
    });
    return temPedido;
  }

  @override
  Widget build(BuildContext context) {
    var listaPedidos = GetIt.I.get<List<PedidoModelo>>();

    return Scaffold(
      appBar: AppBar(
        title: Text(produtoModelo.nome),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, "tela_editar_produto");
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, "tela_adicionar_produto");
              })
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              dotSize: 6,
              //dotBgColor: Colors.transparent,
              autoplay: false,
              images: produtoModelo.imagens.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotIncreasedColor: Colors.blue,
              dotBgColor: Colors.transparent,
              dotColor: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  produtoModelo.nome,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'A partir de',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  'R\$ ' + produtoModelo.preco.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    // color: primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  produtoModelo.descrissao,
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                if (!temPedido(listaPedidos))
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        "Adicionar ao carrinho",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        Navigator.pushNamed(context, "carrinho",
                            arguments: produtoModelo);
                      },
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
