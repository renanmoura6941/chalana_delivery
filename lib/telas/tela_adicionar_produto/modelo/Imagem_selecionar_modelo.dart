import 'dart:io';

class ImagemModelo {
  File imagem;
  bool selecionado;
  String imagemUrl;
  ImagemModelo({this.imagem, this.selecionado, this.imagemUrl}) {
    this.selecionado = selecionado ?? false;
  }
}
