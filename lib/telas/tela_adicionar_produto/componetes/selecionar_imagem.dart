import 'dart:io';

import 'package:flutter/material.dart';

class ImagemWidget extends StatefulWidget {
  File novaImagem;
  String imagemUrl;
  bool selecionado;
  Function(bool) onPressed;

  ImagemWidget({this.novaImagem, this.selecionado, this.onPressed, this.imagemUrl});

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
      child: widget.novaImagem == null
          ? Image.network(widget.imagemUrl)
          : Image.file(
              widget.novaImagem,
              fit: BoxFit.cover,
            ),
    );
  }
}
