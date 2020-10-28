import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TelaEditarProduto extends StatefulWidget {
  @override
  _TelaEditarProdutoState createState() => _TelaEditarProdutoState();
}

class _TelaEditarProdutoState extends State<TelaEditarProduto> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> imagens = [
      "https://delivery.supermuffato.com.br/arquivos/ids/258950-1000-1000/7897395099329.jpg?v=637127241430430000",
      "https://www.imigrantesbebidas.com.br/bebida/images/products/full/222_Cerveja_Heineken_Long_Neck_330_ml.jpg"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar produto"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Carousel(
                  dotSize: 6,
                  autoplay: false,
                  images: imagens.map((url) {
                    return NetworkImage(url);
                  }).toList(),
                  dotIncreasedColor: Colors.blue,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.blue,
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.photo_camera),
                      ),
                      onTap: () async {
                        await getImage();
                      },
                    ))
              ],
            ),
          ),
          // AspectRatio(
          //   aspectRatio: 1,
          //   child: Container(
          //     color: Colors.blue,
          //     child: Center(
          //       child: _image == null ? Icon(Icons.photo, size: 100,) : Image.file(_image),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nome"),
                TextField(),
                Text("Preço"),
                TextField(),
                Text("Descrição"),
                TextField(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Salvar produto",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
