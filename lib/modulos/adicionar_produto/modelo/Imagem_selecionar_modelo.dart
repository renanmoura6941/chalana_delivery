import 'dart:io';

import 'package:chalana_delivery/modelos/foto_modelo.dart';

class ImagemModeloLocal {
  String nome;
  File novaImagem;
  bool selecionado;
  FotoModelo imagem;
  ImagemModeloLocal({this.nome,this.novaImagem, this.selecionado = false, this.imagem});
}
