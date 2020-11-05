import 'dart:async';
import 'dart:io';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/modelo/Imagem_selecionar_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CarrocelImagens {

  final StreamController<List<ImagemModeloLocal>> stream = StreamController();
  Sink<List<ImagemModeloLocal>> get entrada => stream.sink;
  Stream get saida => stream.stream;

  ProdutoModelo produto = ProdutoModelo();
  List<ImagemModeloLocal> listaImagens = [];
  var referenciaImagens;

  pegandoDados(ProdutoModelo produto) {
    this.produto =produto;

    produto.imagens.forEach((imagem) {
      listaImagens.add(ImagemModeloLocal(imagemUrl: imagem.url));
    });
  }

  Future adicionarCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      listaImagens.add(ImagemModeloLocal(novaImagem: File(pickedFile.path)));
      entrada.add(listaImagens);
    }
  }

  Future adicionarGaleria() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      listaImagens.add(ImagemModeloLocal(novaImagem: File(pickedFile.path)));
      entrada.add(listaImagens);
    }
  }

  adicionarImagens() {}

  removerImagem() {
    listaImagens.removeWhere((e) => e.selecionado);
    entrada.add(listaImagens);
  }

  int itemSelecionados() => listaImagens.where((e) => e.selecionado).length;

  bool temItemSelecionado() => itemSelecionados() > 0 ? true : false;

  selecionadoItem(int indice) {
    listaImagens[indice].selecionado = !listaImagens[indice].selecionado;
    entrada.add(listaImagens);
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

  void salvarimagemFirebase( String nomeProduto) async {



    for (final itens in listaImagens) {

      //itens.
      // String url = await salvarImagemFirebase(e.imagem);
      // print("url recuperada $url");
      // produtoModelo.imagens.add(url);
    }
  }

}
