import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/componentes/butao_confirmar/butao_confirmar.dart';
import 'package:chalana_delivery/componentes/image_carrocel/selecionar_imagem.dart';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/helpers/tratamento_erros.dart';
import 'package:chalana_delivery/helpers/validators_functions.dart';
import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';
import 'funcionalidades/editar_regra_negocio.dart';

// ignore: must_be_immutable
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
          backgroundColor: COR_PRINCIPAL,
          radius: 30,
          child: Icon(Icons.remove),
        ),
        onTap: () => editaRegraNegocio.removerImagem());
  }

  Widget butaoTirarFoto(BuildContext context) {
    return InkWell(
        child: CircleAvatar(
          backgroundColor: COR_PRINCIPAL,
          radius: 30,
          child: Icon(
            Icons.photo_camera,
            color: Colors.white,
          ),
        ),
        onTap: () => editaRegraNegocio.produto.imagens.length > 2
            ? popAlerta(context, "Limite máximo de fotos!")
            : _adicionar(context));
  }

  List<Widget> abirImagens(List<FotoModelo> imagens) {
    return List<Widget>.generate(imagens.length, (index) {
      return ImagemWidget(
          onPressed: () => editaRegraNegocio.selecionadoItem(index),
          novaImagem: imagens[index].local ?? null,
          imagemUrl: imagens[index].url,
          selecionado: imagens[index].selecionado);
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

  @override
  void dispose() {
    print("destruir");
    editaRegraNegocio.destruir();
    super.dispose();
  }

  Widget carrocelImagen() {
    return StreamBuilder<List<FotoModelo>>(
      initialData: widget.produtoModelo.imagens,
      stream: editaRegraNegocio.saida,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          print("recontruindo carrocel ${snapshot.data.length}");
          return Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  dotSize: 8,
                  autoplay: false,
                  dotIncreasedColor: COR_PRINCIPAL,
                  dotBgColor: Colors.transparent,
                  dotColor: COR_PRINCIPAL,
                  images: snapshot.data.isEmpty
                      ? IMAGEM_VAZIA
                      : abirImagens(snapshot.data),
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
                      backgroundColor: COR_PRINCIPAL,
                      onPressed: null,
                      label: Text(
                          "${editaRegraNegocio.itemSelecionados} item selecionado",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ))
            ],
          );
        } else {
          return AspectRatio(
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
      backgroundColor: Colors.white,
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
                          return CARREGANDO2;
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

                                Navigator.pushNamedAndRemoveUntil(
                                    context, "tela_menu", (route) => false);
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
