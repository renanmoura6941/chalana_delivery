import 'dart:io';

import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImagemWidget extends StatelessWidget {
  File novaImagem;
  String imagemUrl;
  bool selecionado;
  Function onPressed;

  ImagemWidget(
      {this.novaImagem, this.selecionado, this.onPressed, this.imagemUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selecionado ?? false ? Colors.red : Colors.transparent,
            width: 5.0,
          ),
        ),
        child: imagemUrl != null
            ? Image.network(
                imagemUrl,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  return Center(child: CARREGANDO);
                },
              )
            : Image.file(
                novaImagem,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
