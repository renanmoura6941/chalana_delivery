import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/modulos/principal/componentes/secao_grade.dart';
import 'package:chalana_delivery/modulos/principal/funcionalidades/atualizar_produto.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  final List<ProdutoModelo> produtos;
  const TelaPrincipal({Key key, this.produtos}) : super(key: key);
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  AtualizarProduto atualizarProduto = AtualizarProduto();

  Widget gradeProdutos(List<ProdutoModelo> produtos) {
    return SecaoGrade(produtos);
  }

  Widget aguardandoProdutos(List<ProdutoModelo> produtos) {
    if (atualizarProduto.inicio) atualizarProduto.escultarAlteracoes();

    return StreamBuilder<List<ProdutoModelo>>(
      initialData: produtos,
      stream: atualizarProduto.saida,
      builder: (context, snapshotTwo) {
        print("Construindo a tela de Produtos");
        if (snapshotTwo.hasData) {
          return gradeProdutos(snapshotTwo.data);
        } else {
          return Center(child: CARREGANDO);
        }
      },
    );
  }

  @override
  void dispose() {
    atualizarProduto.destruir();
    print("destruir");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chalana delivery",
        ),
      ),
      body: SafeArea(child: aguardandoProdutos(widget.produtos)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => Navigator.pushNamed(context, "Tela_carrinho"),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
