import 'dart:async';
import 'dart:io';
import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditaRegraNegocio {
  final StreamController<List<FotoModelo>> stream = StreamController();
  Sink<List<FotoModelo>> get entrada => stream.sink;
  Stream get saida => stream.stream;

  final StreamController<bool> streamProcessando = StreamController();
  Sink<bool> get entradaProcesso => streamProcessando.sink;
  Stream get saidaPreocesso => streamProcessando.stream;

  ProdutoModelo produto = ProdutoModelo();
  List<FotoModelo> urlRemover = [];
  bool processando = false;

  void pegandoDados(ProdutoModelo produto) {
    this.produto = produto;
  }

  void removerImagem() {
    print("urls para remover no firebase");

    produto.imagens.forEach((e) {
      if (e.selecionado && e.url != null) {
        urlRemover.add(e);
      }
    });

    urlRemover.addAll(urlRemover.toSet().toList());

    print("${urlRemover.length} url");

    print("Removendo localmente");
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

  Future<void> adicionarCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
      entrada.add(produto.imagens);
    }
  }

  Future<void> adicionarGaleria() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
      entrada.add(produto.imagens);
    }
  }

  Future<void> removerFirebase() async {
    if (urlRemover.isNotEmpty) {
      print("removendo ${urlRemover.length} do firebase");
      urlRemover.forEach((e) async {
        await FirebaseStorage.instance
            .ref()
            .child(produto.id)
            .child(e.uuid)
            .delete();
      });
    } else {
      print("Sem imagens para remover!");
    }
  }

  Future<FotoModelo> salvarFirebaseStorage(File file) async {
    var refencia = FirebaseStorage.instance.ref().child(produto.id);
    String id = Uuid().v1();
    final StorageUploadTask task = await refencia.child(id).putFile(file);
    final StorageTaskSnapshot snapshot = await task.onComplete;
    final String url = await snapshot.ref.getDownloadURL() as String;

    return FotoModelo(url: url, uuid: id);
  }

  Future<void> salvarmagemFirebase() async {
    var imagemNova = produto.imagens.where((e) => e.local != null).toList();
    print(imagemNova);

    if (imagemNova.isNotEmpty) {
      produto.imagens.removeWhere((e) => e.local != null);

      for (final itens in imagemNova) {
        FotoModelo imagem = await salvarFirebaseStorage(itens.local);
        produto.imagens.add(imagem);
      }
    }
  }

  Future<void> editarProduto() async {
    print("produto Editado");

    processando = true;
    streamProcessando.add(processando);
    print("Removendo url firebase");
    await removerFirebase();
    print("salvando imagem Firebase");

    await salvarmagemFirebase();
    print("atualizando produto Firebase");

    await produto.atualizar();
    print("produto Editado com SUCESSO!");
    processando = false;
    streamProcessando.add(processando);
  }
}
