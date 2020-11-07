import 'dart:async';
import 'dart:io';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditaRegraNegocio {
  final StreamController<List<FotoModelo>> stream = StreamController();
  Sink<List<FotoModelo>> get entrada => stream.sink;
  Stream get saida => stream.stream;

  final StreamController<bool> streamProcessando = StreamController();
  Sink<bool> get entradaProcesso => streamProcessando.sink;
  Stream get saidaPreocesso => streamProcessando.stream;

  ProdutoModelo produto;
  List<FotoModelo> urlRemover = [];
  bool processando = false;

  void pegandoDados(ProdutoModelo produtodData) {
    this.produto = ProdutoModelo(
        nome: produtodData.nome,
        acessos: produtodData.acessos,
        categorias: produtodData.categorias,
        descrissao: produtodData.descrissao,
        id: produtodData.id,
        imagens: produtodData.imagens,
        preco: produtodData.preco);
  }

  void removerImagem() {
    debugPrint("verificando urls para remover no firebase......");

    produto.imagens.forEach((e) {
      if (e.selecionado && e.url != null) {
        urlRemover.add(e);
      }
    });

    debugPrint("${urlRemover.length} url encontradas");

    debugPrint(
        "Removendo localmente ${produto.imagens.where((e) => e.selecionado).toList().length}");
    produto.imagens.removeWhere((e) => e.selecionado);
    debugPrint("Removido localmente com SUCESSO(V)");
 
    entrada.add(produto.imagens);
  }

  void selecionadoItem(int indice) {
    produto.imagens[indice].selecionado = !produto.imagens[indice].selecionado;
    entrada.add(produto.imagens);
  }

  int get itemSelecionados =>
      produto.imagens.where((e) => e.selecionado).length;

  bool get temItemSelecionado => itemSelecionados > 0 ? true : false;

  Future<void> adicionarCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: QUALIDADE);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
      entrada.add(produto.imagens);
    }
  }

  Future<void> adicionarGaleria() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery, imageQuality: QUALIDADE);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
      entrada.add(produto.imagens);
    }
  }

  Future<void> removerFirebase() async {
    debugPrint("removendo imagem no storage......");

    if (urlRemover.isNotEmpty) {
      debugPrint("removendo ${urlRemover.length} do firebase");
      urlRemover.forEach((e) async {
        await FirebaseStorage.instance
            .ref()
            .child(produto.id)
            .child(e.uuid)
            .delete();
        debugPrint("romovido imagem no storage SUCESSO(V");
      });
    } else {
      debugPrint("Sem imagens para remover!");
    }
  }

  Future<FotoModelo> salvarFirebaseStorage(File file) async {
    var refencia = FirebaseStorage.instance.ref().child(produto.id);
    String id = Uuid().v1();
    debugPrint("Salvando imagem no storage......");
    final StorageUploadTask task = await refencia.child(id).putFile(file);
    final StorageTaskSnapshot snapshot = await task.onComplete;
    debugPrint("Salvando imagem no storage SUCESSO(V)");
    debugPrint(
        "obtendo url da imagens refente ao produto ${produto.nome}......");

    final String url = await snapshot.ref.getDownloadURL() as String;
    debugPrint("url obitida $url com SUCESSO! (V)");

    return FotoModelo(url: url, uuid: id);
  }

  Future<void> salvarmagemFirebase() async {
    debugPrint("verificando imagens novas......");

    var imagemNova = produto.imagens.where((e) => e.local != null).toList();
    debugPrint("(${imagemNova.length}) imagens novas");

    if (imagemNova.isNotEmpty) {
      produto.imagens.removeWhere((e) => e.local != null);

      for (final itens in imagemNova) {
        FotoModelo imagem = await salvarFirebaseStorage(itens.local);
        produto.imagens.add(imagem);
      }
      debugPrint("Salvando no firebase storage SUCESSO (V)");
    }
  }

  Future<void> editarProduto() async {
    debugPrint("produto editado......");
    processando = true;
    streamProcessando.add(processando);

    await removerFirebase();

    await salvarmagemFirebase();

    await produto.atualizar();

    processando = false;
    streamProcessando.add(processando);
  }

  destruir() {
    streamProcessando.close();
    stream.close();
  }
}
