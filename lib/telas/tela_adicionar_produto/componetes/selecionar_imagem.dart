import 'dart:io';

import 'package:flutter/material.dart';

class ImagemWidget extends StatefulWidget {
  File imagem;
  String imagemUrl;
  bool selecionado;
  Function(bool) onPressed;

  ImagemWidget({this.imagem, this.selecionado, this.onPressed, this.imagemUrl});

  @override
  _ImagemWidgetState createState() => _ImagemWidgetState();
}

class _ImagemWidgetState extends State<ImagemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.selecionado ?? false
              ? Colors.red
              : Colors.transparent, //                   <--- border color
          width: 5.0,
        ),
      ),
      child: widget.imagem == null
          ? Image.network(widget.imagemUrl)
          : Image.file(
              widget.imagem,
              fit: BoxFit.cover,
            ),
    );
  }
}
