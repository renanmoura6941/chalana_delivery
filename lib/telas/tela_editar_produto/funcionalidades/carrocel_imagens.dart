import 'dart:async';
import 'dart:io';
import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/modelo/Imagem_selecionar_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CarrocelImagens {
  final StreamController<List<FotoModelo>> stream = StreamController();
  Sink<List<FotoModelo>> get entrada => stream.sink;
  Stream get saida => stream.stream;

  ProdutoModelo produto = ProdutoModelo();
  List<FotoModelo> urlRemover;

  pegandoDados(ProdutoModelo produto) {
    this.produto = produto;
  }

  Future adicionarCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
      entrada.add(produto.imagens);
    }
  }

  Future adicionarGaleria() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      produto.imagens.add(FotoModelo(local: File(pickedFile.path), url: null));
      entrada.add(produto.imagens);
    }
  }

  Future<void> removerFirebase() async {
    urlRemover =
        produto.imagens.where((e) => e.selecionado && e.url != null).toList();

    if (urlRemover.isNotEmpty) {
      urlRemover.forEach((e) async {
        await FirebaseStorage.instance
            .ref()
            .child(produto.nome)
            .child(e.uuid)
            .delete();
      });
    }
  }

  void removerImagem()  {
    print("urls para remover no firebase");
    urlRemover =
        produto.imagens.where((e) => e.selecionado && e.url != null).toList();
    print("${urlRemover} url");

    print("Removendo localmente");
    produto.imagens.removeWhere((e) => e.selecionado);

    entrada.add(produto.imagens);
  }

  int itemSelecionados() => produto.imagens.where((e) => e.selecionado).length;

  bool temItemSelecionado() => itemSelecionados() > 0 ? true : false;

  selecionadoItem(int indice) {
    produto.imagens[indice].selecionado = !produto.imagens[indice].selecionado;
    entrada.add(produto.imagens);
  }

  //  Future<String> salvarImagemFirebase(File imagem) async {
  //   var storageRef = FirebaseStorage.instance.ref().child(produtoModelo.nome);

  //   final StorageUploadTask task =
  //       storageRef.child(Uuid().v1()).putFile(imagem);

  //   final StorageTaskSnapshot snapshot = await task.onComplete;
  //   final String url = await snapshot.ref.getDownloadURL() as String;

  //   return url;
  // }

  //  Future<String> imagemFirebase(File imagem) async {
  //   var storageRef = FirebaseStorage.instance.ref().child(produtoModelo.nome);

  //   final StorageUploadTask task =
  //       storageRef.child(Uuid().v1()).putFile(imagem);

  //   final StorageTaskSnapshot snapshot = await task.onComplete;
  //   final String url = await snapshot.ref.getDownloadURL() as String;

  //   return url;
  // }

  void salvarimagemFirebase(String nomeProduto) async {
    for (final itens in produto.imagens) {
      //itens.
      // String url = await salvarImagemFirebase(e.imagem);
      // print("url recuperada $url");
      // produtoModelo.imagens.add(url);
    }
  }
}
