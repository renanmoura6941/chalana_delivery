import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/modulos/principal/componentes/card.dart';
import 'package:chalana_delivery/modulos/principal/funcionalidades/atualizar_produto.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  void initState() {
    // TODO: implement initState
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        builder: (context, snapshotTwo) {
          print("Construindo a tela de Produtos");
          if (snapshotTwo.hasData) {
            return gradeProdutos(snapshotTwo.data);
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }

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
        child: FutureBuilder<List<ProdutoModelo>>(
            future: GetIt.I.get<Repositorio>().getProdutos(),
            builder: (ctx, snapshot) {

              if (snapshot.hasData) {
                return aguardandoProdutos(snapshot);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      )),
    );
  }
}
