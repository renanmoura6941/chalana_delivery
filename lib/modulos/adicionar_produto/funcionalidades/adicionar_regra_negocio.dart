import 'dart:async';
import 'dart:io';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AdicionarRegraNegocio {
  final StreamController<List<FotoModelo>> stream = StreamController();
  Sink<List<FotoModelo>> get entrada => stream.sink;
  Stream get saida => stream.stream;

  final StreamController<bool> streamProcessando = StreamController();
  Sink<bool> get entradaProcesso => streamProcessando.sink;
  Stream get saidaPreocesso => streamProcessando.stream;

  ProdutoModelo produto = ProdutoModelo(imagens: []);

  bool processando = false;

  void removerImagem() {
    produto.imagens.removeWhere((e) => e.selecionado);
    entrada.add(produto.imagens);
  }

  void selecionadoItem(int indice) {
    produto.imagens[indice].selecionado = !produto.imagens[indice].selecionado;
    entrada.add(produto.imagens);
  }

  int get itemSelecionados =>
      produto.imagens.where((e) => e.selecionado).length;

  bool get temItemSelecionado => itemSelecionados > 0 ? true : false;

  Future<void> adicionarCamera(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: QUALIDADE);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
    }
    Navigator.of(context).pop();
    entrada.add(produto.imagens);
  }

  Future<void> adicionarGaleria(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: QUALIDADE);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
    }
    Navigator.of(context).pop();
    entrada.add(produto.imagens);
  }

  Future<FotoModelo> salvarFirestore(File imagem) async {
    var storageRef = await FirebaseStorage.instance.ref().child(produto.id);
    String uuid = Uuid().v1();
    final StorageUploadTask task = await storageRef.child(uuid).putFile(imagem);
    final StorageTaskSnapshot snapshot = await task.onComplete;
    final String url = await snapshot.ref.getDownloadURL() as String;
    return FotoModelo(url: url, uuid: uuid);
  }

  Future<void> salvarFirebase() async {
    print(produto.imagens.length);

    var imagens = produto.imagens;
    produto.imagens = [];

    for (final e in imagens) {
      FotoModelo fotoModelo = await salvarFirestore(e.local);
      produto.imagens.add(fotoModelo);
    }
  }

  Future<void> adicionarProduto(BuildContext context) async {
    processando = true;
    streamProcessando.add(processando);

    await produto.salvar();

    await salvarFirebase();

    await produto.atualizar();

    processando = false;
    streamProcessando.add(processando);
  }
}
