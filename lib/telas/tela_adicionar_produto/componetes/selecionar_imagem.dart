import 'dart:io';

import 'package:flutter/material.dart';

class ImagemWidget extends StatefulWidget {
  File novaImagem;
  String imagemUrl;
  bool selecionado;
  Function onPressed;

  ImagemWidget({this.novaImagem, this.selecionado, this.onPressed, this.imagemUrl});

  @override
  _ImagemWidgetState createState() => _ImagemWidgetState();
}

class _ImagemWidgetState extends State<ImagemWidget> {
 
 


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onLongPress: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.selecionado ?? false
                ? Colors.red
                : Colors.transparent, //                   <--- border color
            width: 5.0,
          ),
        ),
        child: widget.imagemUrl != null
            ? Image.network(widget.imagemUrl)
            : Image.file(
                widget.novaImagem,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

