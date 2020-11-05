import 'dart:io';

class ImagemModeloLocal {
  File novaImagem;
  bool selecionado;
  String imagemUrl;
  ImagemModeloLocal({this.novaImagem, this.selecionado = false, this.imagemUrl});
}
