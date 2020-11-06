import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/componentes/butao_confirmar/butao_confirmar.dart';
import 'package:chalana_delivery/helpers/validators_functions.dart';
import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/componetes/selecionar_imagem.dart';
import 'package:chalana_delivery/telas/tela_editar_produto/funcionalidades/editar_regra_negocio.dart';
import 'package:flutter/material.dart';

import 'funcionalidades/editar_regra_negocio.dart';

class TelaEditarProduto extends StatefulWidget {
  ProdutoModelo produtoModelo;
  TelaEditarProduto(this.produtoModelo);
  @override
  _TelaEditarProdutoState createState() => _TelaEditarProdutoState();
}

class _TelaEditarProdutoState extends State<TelaEditarProduto> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  EditaRegraNegocio editaRegraNegocio = EditaRegraNegocio();

  Widget butaoRemover() {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.remove),
        ),
        onTap: () => editaRegraNegocio.removerImagem());
  }

  Widget butaoTirarFoto(BuildContext context) {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.photo_camera),
        ),
        onTap: () => editaRegraNegocio.produto.imagens.length > 2
            ? popAlerta(context, "Limite máximo de fotos!")
            : _adicionar(context));
  }

  List<Widget> abirImagens() {
    return List<Widget>.generate(editaRegraNegocio.produto.imagens.length,
        (index) {
      return ImagemWidget(
          onPressed: () => editaRegraNegocio.selecionadoItem(index),
          novaImagem: editaRegraNegocio.produto.imagens[index].local ?? null,
          imagemUrl: editaRegraNegocio.produto.imagens[index].url,
          selecionado: editaRegraNegocio.produto.imagens[index].selecionado);
    });
  }

  void _adicionar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Galeria'),
                      onTap: () async {
                        await editaRegraNegocio.adicionarGaleria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () async {
                      await editaRegraNegocio.adicionarCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    editaRegraNegocio.pegandoDados(widget.produtoModelo);
    super.initState();
  }

  carrocelImagen() {
    return StreamBuilder<List<FotoModelo>>(
      initialData: editaRegraNegocio.produto.imagens,
      stream: editaRegraNegocio.saida,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  dotSize: 6,
                  autoplay: false,
                  dotIncreasedColor: Colors.blue,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.blue,
                  images: editaRegraNegocio.produto.imagens.isEmpty
                      ? [
                          Icon(
                            Icons.photo,
                            size: 100,
                          )
                        ]
                      : abirImagens(),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: editaRegraNegocio.temItemSelecionado
                      ? butaoRemover()
                      : butaoTirarFoto(context)),
              if (editaRegraNegocio.temItemSelecionado)
                Positioned(
                    bottom: 0,
                    left: 7,
                    child: FloatingActionButton.extended(
                      onPressed: null,
                      label: Text(
                          "${editaRegraNegocio.itemSelecionados} item selecionado",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ))
            ],
          );
        } else {
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              dotSize: 6,
              autoplay: false,
              dotIncreasedColor: Colors.blue,
              dotBgColor: Colors.transparent,
              dotColor: Colors.blue,
              images: [
                Icon(
                  Icons.photo,
                  size: 100,
                )
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editando produto"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          carrocelImagen(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nome"),
                  TextFormField(
                      initialValue: widget.produtoModelo.nome.toString(),
                      validator: (nome) => validarNome(nome),
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) =>
                          editaRegraNegocio.produto..nome = entrada),
                  Text("Preço"),
                  TextFormField(
                      initialValue:
                          widget.produtoModelo.preco.toStringAsFixed(2),
                      validator: (preco) => validarPreco(preco),
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) =>
                          editaRegraNegocio.produto.preco = num.parse(entrada)),
                  Text("Descrição"),
                  TextFormField(
                      initialValue: widget.produtoModelo.descrissao,
                      validator: (descricao) => validarDescricao(descricao),
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) =>
                          editaRegraNegocio.produto.descrissao = entrada),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<bool>(
                      initialData: editaRegraNegocio.processando,
                      stream: editaRegraNegocio.saidaPreocesso,
                      builder: (context, snapshot) {
                        if (snapshot.data) {
                          return CircularProgressIndicator();
                        }
                        return ButaoConfirmar(
                            titulo: "Editar produto",
                            onPressed: () async {
                              if (formkey.currentState.validate() &&
                                  validarImagens(
                                      editaRegraNegocio.produto.imagens,
                                      context)) {
                                formkey.currentState.save();
                                await editaRegraNegocio.editarProduto();
                         
                                Navigator.pushNamedAndRemoveUntil(context, "principal", (route) => false);
                              }
                            });
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
