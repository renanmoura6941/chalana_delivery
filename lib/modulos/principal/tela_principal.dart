import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/modulos/principal/componentes/section_staggered.dart';
import 'package:chalana_delivery/modulos/principal/funcionalidades/atualizar_produto.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  final List<ProdutoModelo> produtos;

  const TelaPrincipal({Key key, this.produtos}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    AtualizarProduto atualizarProduto = AtualizarProduto();

    Widget gradeProdutos(List<ProdutoModelo> produtos) {
      return SectionStaggered(produtos);
      // return GridView.builder(
      //   physics: BouncingScrollPhysics(),
      //   //   padding: EdgeInsets.symmetric(vertical: 10),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     childAspectRatio:1,
      //     crossAxisSpacing:1,
      //     mainAxisSpacing: 10
      //   ),
      //   scrollDirection: Axis.vertical,
      //   shrinkWrap: true,
      //   itemCount: produtos.length,
      //   itemBuilder: (_, indice) {
      //     return CardProduto(produtos[indice]);
      //   },
      // );
    }

    Widget aguardandoProdutos(List<ProdutoModelo> produtos) {
      atualizarProduto.escultarAlteracoes();
      return StreamBuilder<List<ProdutoModelo>>(
        initialData: produtos,
        stream: atualizarProduto.saida,
        builder: (context, snapshotTwo) {
          print("Construindo a tela de Produtos");
          if (snapshotTwo.hasData) {
            return 
              ListView(
                children: [
                  gradeProdutos(snapshotTwo.data),
                ],
              );
              
              
          } else {
            return Center(child: CARREGANDO);
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
      //  backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: aguardandoProdutos(widget.produtos))),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, "Tela_carrinho");
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
