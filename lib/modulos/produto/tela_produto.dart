import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/helpers/tratamento_erros.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/modulos/produto/funcinalidades/produto_regra_negicio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TelaProduto extends StatefulWidget {
  final ProdutoModelo produto;
  TelaProduto(this.produto);

  @override
  _TelaProdutoState createState() => _TelaProdutoState();
}

class _TelaProdutoState extends State<TelaProduto> {
  bool permissao = false;

  Future<void> removerImagemStorege() async {
    var referencia =
        await FirebaseStorage.instance.ref().child(widget.produto.id);

    widget.produto.imagens.forEach((e) async {
      await referencia.child(e.uuid).delete();
    });
  }

  PeodutoRegraNegocio produtoRegraNegocio;
  @override
  void initState() {
    produtoRegraNegocio = PeodutoRegraNegocio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("reconstruindo tela produto......");

    produtoRegraNegocio.estaNoCarrinho(widget.produto);

    excluirAlerta(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) => SimpleDialog(
                //titlePadding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                backgroundColor: COR_PRINCIPAL,
                title: Center(
                  child: Container(
                   // color: Colors.red,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tem certeza que deseja excluir?"),
                          Row(
                            children: [
                              RaisedButton(
                                onPressed: () async {
                                  await removerImagemStorege();
                                  await widget.produto.remover();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Sim"),
                              ),
                              Expanded(child: Text("")),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Não"),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ));
    }

    List<Widget> adm = <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "tela_adicionar_produto");
          }),
      IconButton(
          icon: Icon(Icons.edit),
          onPressed: () async {
            Navigator.pushNamed(context, "tela_editar_produto",
                arguments: widget.produto.copiar());
          }),
      IconButton(
          icon: Icon(Icons.highlight_remove),
          onPressed: () {
            excluirAlerta(context);
          }),
    ];

    return Scaffold(
        appBar: AppBar(
            title: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    permissao = !permissao;
                  });
                },
                child: Text(widget.produto.nome)),
            centerTitle: true,
            actions: permissao ? adm : []),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                dotSize: 6,
                //dotBgColor: Colors.transparent,
                autoplay: false,
                images: widget.produto.imagens == null ||
                        widget.produto.imagens.isEmpty ||
                        widget.produto.imagens.first == null
                    ? IMAGEM_VAZIA
                    : widget.produto.imagens.map((imagem) {
                        return CachedNetworkImage(
                          imageUrl: imagem.url,
                          placeholder: (context, url) => CARREGANDO2,
                          errorWidget: (context, url, error) =>
                              Center(child: ERRO_IMAGEM),
                        );
                      }).toList(),
                dotIncreasedColor: COR_PRINCIPAL,
                dotBgColor: Colors.transparent,
                dotColor: COR_PRINCIPAL,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.produto.nome,
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
                    'R\$ ' + widget.produto.preco.toStringAsFixed(2),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    widget.produto.descrissao,
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 60,
                  ),

                  // if (!produtoRegraNegocio.noCarrinho)
                  //   ButaoConfirmar(
                  //       titulo: "Adicionar ao carrinho",
                  //       cor:COR_PRINCIPAL,
                  //       onPressed: () async {
                  // produtoRegraNegocio.addCarrinho(widget.produto);

                  // var pop = await Navigator.pushNamed(
                  //     context, "Tela_carrinho");
                  // print(pop);
                  // if (pop == true || pop == null) {
                  //   setState(() {
                  //     produtoRegraNegocio
                  //         .estaNoCarrinho(widget.produto);
                  //   });
                  // }
                  //       })
                ],
              ),
            )
          ],
        ),
        floatingActionButton: produtoRegraNegocio.noCarrinho
            ? FloatingActionButton.extended(
                label: Text("Produto está no carrinho"),
                backgroundColor: Colors.red,
                onPressed: () {
                  Navigator.pushNamed(context, "Tela_carrinho");
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              )
            : FloatingActionButton.extended(
                splashColor: COR_PRINCIPAL,
                label: Text("Adicionar ao carrinho"),
                backgroundColor: Colors.red,
                onPressed: () async {
                  produtoRegraNegocio.addCarrinho(widget.produto);

                  var pop = await Navigator.pushNamed(context, "Tela_carrinho");
                  print(pop);
                  if (pop == true || pop == null) {
                    setState(() {
                      produtoRegraNegocio.estaNoCarrinho(widget.produto);
                    });
                  }
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
              ));
  }
}
