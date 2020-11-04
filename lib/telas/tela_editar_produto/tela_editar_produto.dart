import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/componentes/butao_confirmar/butao_confirmar.dart';
import 'package:chalana_delivery/helpers/validators_functions.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/componetes/selecionar_imagem.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/modelo/Imagem_selecionar_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'funcionalidades/carrocel_imagens.dart';

class TelaEditarProduto extends StatefulWidget {
  ProdutoModelo produtoModelo;
  TelaEditarProduto(this.produtoModelo);
  @override
  _TelaEditarProdutoState createState() => _TelaEditarProdutoState();
}

class _TelaEditarProdutoState extends State<TelaEditarProduto> {
  List<ImagemModelo> imagemModelo;
  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  ProdutoModelo produtoModelo = ProdutoModelo();
  bool processando = false;
  CarrocelImagens carrocelImagens = CarrocelImagens();

  Widget butaoRemover() {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.remove),
        ),
        onTap: () => carrocelImagens.removerImagem());
  }

  Widget butaoTirarFoto(BuildContext context) {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.photo_camera),
        ),
        onTap: () => carrocelImagens.listaImagens.length > 2
            ? popAlerta(context, "Limite máximo de fotos!")
            : _adicionar(context));
  }

  List<Widget> abirImagens() {
    return List<Widget>.generate(carrocelImagens.listaImagens.length, (index) {
      return GestureDetector(
        onLongPress: () => carrocelImagens.selecionadoItem(index),
        child: ImagemWidget(
            novaImagem: carrocelImagens.listaImagens[index].novaImagem ?? null,
            imagemUrl: carrocelImagens.listaImagens[index].imagemUrl,
            selecionado: carrocelImagens.listaImagens[index].selecionado),
      );
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
                      onTap: () {
                        carrocelImagens.adicionarGaleria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      carrocelImagens.adicionarCamera();
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
    carrocelImagens.pegandoDados(widget.produtoModelo);
    super.initState();
  }

  carrocelImagen() {
    print(carrocelImagens.listaImagens.length);
    return StreamBuilder<List<ImagemModelo>>(
      initialData: carrocelImagens.listaImagens,
      stream: carrocelImagens.saida,
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
                  images: abirImagens(),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: carrocelImagens.temItemSelecionado()
                      ? butaoRemover()
                      : butaoTirarFoto(context)),
              if (carrocelImagens.temItemSelecionado())
                Positioned(
                    bottom: 0,
                    left: 7,
                    child: FloatingActionButton.extended(
                      onPressed: null,
                      label: Text(
                          "${carrocelImagens.itemSelecionados()} item selecionado",
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
        title: Text("Adicionar produto"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          carrocelImagen(),
          // Stack(
          //   children: [
          //     AspectRatio(
          //       aspectRatio: 1,
          //       child: Carousel(
          //         dotSize: 6,
          //         autoplay: false,
          //         dotIncreasedColor: Colors.blue,
          //         dotBgColor: Colors.transparent,
          //         dotColor: Colors.blue,
          //         images: imagemModelo.isEmpty
          //             ? [
          //                 Icon(
          //                   Icons.photo,
          //                   size: 100,
          //                 )
          //               ]
          //             : abirImagens(),
          //       ),
          //     ),
          //     Positioned(
          //         bottom: 1,
          //         right: 1,
          //         child: temItemSelecionado()
          //             ? butaoRemover()
          //             : butaoTirarFoto(context)),
          //     if (temItemSelecionado())
          //       Positioned(
          //           bottom: 0,
          //           left: 7,
          //           child: FloatingActionButton.extended(
          //             onPressed: null,
          //             label: Text("${itemselecionados()} item selecionado",
          //                 style: TextStyle(
          //                     fontSize: 15, fontWeight: FontWeight.bold)),
          //           ))
          //   ],
          // ),
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
                      onSaved: (entrada) => produtoModelo.nome = entrada),
                  Text("Preço"),
                  TextFormField(
                      initialValue:
                          widget.produtoModelo.preco.toStringAsFixed(2),
                      validator: (preco) => validarPreco(preco),
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) =>
                          produtoModelo.preco = num.parse(entrada)),
                  Text("Descrição"),
                  TextFormField(
                      initialValue: widget.produtoModelo.descrissao,
                      validator: (descricao) => validarDescricao(descricao),
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) => produtoModelo.descrissao = entrada),
                  SizedBox(
                    height: 30,
                  ),
                  processando
                      ? CircularProgressIndicator()
                      : ButaoConfirmar(
                          titulo: "Adicionar produto",
                          onPressed: () async {
                            // if (formkey.currentState.validate() &&
                            //     validarFoto(imagemModelo, context)) {
                            //   setState(() {
                            //     processando = true;
                            //   });
                            //   formkey.currentState.save();

                            //   await salvarFirebase();

                            //   produtoModelo.salvar();
                            //   Navigator.pushReplacementNamed(
                            //       context, "principal");
                            // }
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
