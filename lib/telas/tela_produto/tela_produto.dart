import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../modelos/pedido_modelo.dart';

class TelaProduto extends StatefulWidget {
  final ProdutoModelo produtoModelo;
  TelaProduto(this.produtoModelo);

  @override
  _TelaProdutoState createState() => _TelaProdutoState();
}

class _TelaProdutoState extends State<TelaProduto> {
  bool esta_no_carrinho = false;
  List<PedidoModelo> list_pedidos = GetIt.I.get<List<PedidoModelo>>();

  bool estaNoCarrinho() {
    return list_pedidos
        .where((e) => e.produto.id == widget.produtoModelo.id)
        .isNotEmpty;
  }

  Future<void> removerImagemStorege() async {
    var referencia =
        await FirebaseStorage.instance.ref().child(widget.produtoModelo.id);
    
    widget.produtoModelo.imagens.forEach((e) async {
      await referencia.child(e.uuid).delete();
    });
  }

  @override
  void initState() {
    setState(() {
      esta_no_carrinho = estaNoCarrinho();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produtoModelo.nome),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.highlight_remove),
              onPressed: () async {
                await removerImagemStorege();
                await widget.produtoModelo.remover();
                Navigator.of(context).pop();
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
              images: widget.produtoModelo.imagens.map((imagem) {
                return Image.network(imagem.url, loadingBuilder:
                    (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                });
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
                  widget.produtoModelo.nome,
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
                  'R\$ ' + widget.produtoModelo.preco.toStringAsFixed(2),
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
                  widget.produtoModelo.descrissao,
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                esta_no_carrinho
                    ? Container(
                        width: double.infinity,
                        color: Colors.green[400],
                        alignment: Alignment.center,
                        height: 45,
                        child: Text(
                          "Produto está no carrinho",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 45,
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            "Adicionar ao carrinho",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            list_pedidos.add(
                              PedidoModelo(
                                quantidade: 1,
                                produto: widget.produtoModelo,
                              ),
                            );
                            setState(() {
                              esta_no_carrinho = estaNoCarrinho();
                            });
                          },
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
