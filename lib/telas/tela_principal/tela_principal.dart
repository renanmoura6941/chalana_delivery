import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:chalana_delivery/telas/tela_principal/componentes/card.dart';
import 'package:chalana_delivery/telas/tela_principal/funcionalidades/atualizar_produto.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  AtualizarProduto atualizarProduto = AtualizarProduto();

  Widget gradeProdutos(List<ProdutoModelo> produtos) {
    return GridView.count(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10),
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: produtos.map((produto) {
          return CardPrincipal(produto);
        }).toList());
  }

  Widget aguardandoProdutos(AsyncSnapshot<List<ProdutoModelo>> snapshot) {
    atualizarProduto.escultarAlteracoes();
    return StreamBuilder<List<ProdutoModelo>>(
      initialData: snapshot.data,
      stream: atualizarProduto.saida,
      builder: (context, snapshot) {
        print("Construindo a tela de Produtos");
        if (snapshot.hasData) {
          return gradeProdutos(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chalana delivery",
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, "tela_adicionar_produto");
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
            child: FutureBuilder<List<ProdutoModelo>>(
                future: GetIt.I.get<Repositorio>().getProdutos(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    return aguardandoProdutos(snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                })),
      )),
    );
  }
}
