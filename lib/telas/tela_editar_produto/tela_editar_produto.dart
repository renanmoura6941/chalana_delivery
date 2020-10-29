import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TelaEditarProduto extends StatefulWidget {
  ProdutoModelo produtoModelo;
  TelaEditarProduto(this.produtoModelo);
  @override
  _TelaEditarProdutoState createState() => _TelaEditarProdutoState();
}

class _TelaEditarProdutoState extends State<TelaEditarProduto> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  List<String> imagens = [];
  final picker = ImagePicker();
  File _image;

  Future _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Galeria'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void carregarDadosProduto() {
    nomeController.text = widget.produtoModelo.nome;
    precoController.text = widget.produtoModelo.preco.toStringAsFixed(2);
    descricaoController.text = widget.produtoModelo.descrissao;
    imagens = widget.produtoModelo.imagens;
  }

  @override
  void initState() {
    carregarDadosProduto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    return Image.network(url, loadingBuilder:
                        (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    });
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
                      onTap: () {
                        _showPicker(context);
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
                TextFormField(
                  controller: nomeController,
                ),
                Text("Preço"),
                TextFormField(
                  controller: precoController,
                ),
                Text("Descrição"),
                TextFormField(
                  controller: descricaoController,
                ),
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
