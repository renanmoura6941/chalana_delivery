import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/componentes/butao_confirmar/butao_confirmar.dart';
import 'package:chalana_delivery/componentes/image_carrocel/selecionar_imagem.dart';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/helpers/tratamento_erros.dart';
import 'package:chalana_delivery/helpers/validators_functions.dart';
import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modulos/adicionar_produto/funcionalidades/adicionar_regra_negocio.dart';
import 'package:flutter/material.dart';

class TelaAdicionarProduto extends StatefulWidget {
  @override
  _TelaAdicionarProdutoState createState() => _TelaAdicionarProdutoState();
}

class _TelaAdicionarProdutoState extends State<TelaAdicionarProduto> {
  AdicionarRegraNegocio adicionarRegraNegocio = AdicionarRegraNegocio();
  final GlobalKey<FormState> chave = GlobalKey<FormState>();

  Widget butaoRemover() {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.highlight_remove),
        ),
        onTap: () => adicionarRegraNegocio.removerImagem());
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
        onTap: () => adicionarRegraNegocio.produto.imagens.length > 2
            ? popAlerta(context, "Limite máximo de fotos!")
            : _adicionar(context));
  }

  List<Widget> abirImagens(List<FotoModelo> imagens) {
    return List<Widget>.generate(imagens.length, (index) {
      return ImagemWidget(
          onPressed: () => adicionarRegraNegocio.selecionadoItem(index),
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
                        await adicionarRegraNegocio.adicionarGaleria(context);
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () async {
                      await adicionarRegraNegocio.adicionarCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget carrocelImagen() {
    return StreamBuilder<List<FotoModelo>>(
      initialData: [],
      stream: adicionarRegraNegocio.saida,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  dotSize: 6,
                  autoplay: false,
                  dotIncreasedColor: COR_PRINCIPAL,
                  dotBgColor: Colors.transparent,
                  dotColor: COR_PRINCIPAL,
                  images: adicionarRegraNegocio.produto.imagens.isEmpty
                      ? IMAGEM_VAZIA
                      : abirImagens(snapshot.data),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: adicionarRegraNegocio.temItemSelecionado
                      ? butaoRemover()
                      : butaoTirarFoto(context)),
              if (adicionarRegraNegocio.temItemSelecionado)
                Positioned(
                    bottom: 0,
                    left: 7,
                    child: FloatingActionButton.extended(
                      onPressed: null,
                      label: Text(
                          "${adicionarRegraNegocio.itemSelecionados} item selecionado",
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
              dotIncreasedColor: COR_PRINCIPAL,
              dotBgColor: Colors.transparent,
              dotColor: COR_PRINCIPAL,
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
  void dispose() {
    print("destruir");
    adicionarRegraNegocio.destruir();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionando produto"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          carrocelImagen(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: chave,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nome"),
                  TextFormField(
                      validator: (nome) => validarNome(nome),
                      onSaved: (entrada) =>
                          adicionarRegraNegocio.produto..nome = entrada),
                  Text("Preço"),
                  TextFormField(
                    validator: (preco) => validarPreco(preco),
                    onSaved: (entrada) => adicionarRegraNegocio.produto.preco =
                        num.parse(entrada),
                  ),
                  Text("Descrição"),
                  TextFormField(
                    validator: (descricao) => validarDescricao(descricao),
                    onSaved: (entrada) =>
                        adicionarRegraNegocio.produto.descrissao = entrada,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<bool>(
                      initialData: adicionarRegraNegocio.processando,
                      stream: adicionarRegraNegocio.saidaPreocesso,
                      builder: (context, snapshot) {
                        if (snapshot.data) {
                          return CARREGANDO2;
                        }
                        return ButaoConfirmar(
                            titulo: "Adicionar produto",
                            cor: COR_PRINCIPAL,
                            onPressed: () async {
                              if (chave.currentState.validate() &&
                                  validarImagens(
                                      adicionarRegraNegocio.produto.imagens,
                                      context)) {
                                chave.currentState.save();
                                await adicionarRegraNegocio
                                    .adicionarProduto(context);
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
