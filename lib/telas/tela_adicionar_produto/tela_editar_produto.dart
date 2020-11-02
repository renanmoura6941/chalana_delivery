import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TelaAdicionarProduto extends StatefulWidget {
  @override
  _TelaAdicionarProdutoState createState() => _TelaAdicionarProdutoState();
}

class _TelaAdicionarProdutoState extends State<TelaAdicionarProduto> {
  File _image;
  final picker = ImagePicker();
  List produtoImagensLocal;

  Future<void> _recuperarImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    print(url);
  }

  Future _uploadImagem() async {
    //referencia o arquivo
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaraiz = storage.ref();
    StorageReference arquivo = pastaraiz.child("fotos").child("foto.jpg");

    StorageUploadTask task = arquivo.putFile(_image);

    task.events.listen((event) {
      if (event.type == StorageTaskEventType.progress) {
        print("em progresso");
      } else if (event.type == StorageTaskEventType.failure) {
        print("falha na foto");
      } else if (event.type == StorageTaskEventType.success) {
        print("sucesso na foto");
      }
    });

    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recuperarImagem(snapshot);
    });
  }

  Future _imagenCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        produtoImagensLocal.add(Image.file(_image));
      });
    } else {
      print('No image selected.');
    }
  }

  Future _imagenGaleria() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        produtoImagensLocal.add(Image.file(_image));
      });
    } else {
      print('No image selected.');
    }
  }

  remover() {
    setState(() {
      produtoImagensLocal.removeLast();
    });
  }

  void _adicionar(context) {
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
                        _imagenGaleria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imagenCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    produtoImagensLocal = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar produto"),
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
                  images: produtoImagensLocal.isEmpty
                      ? [
                          Center(
                              child: Icon(
                            Icons.photo,
                            size: 100,
                          ))
                        ]
                      : produtoImagensLocal,
                  dotIncreasedColor: Colors.blue,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.blue,
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: Row(
                      children: [
                        if (produtoImagensLocal.isNotEmpty)
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: InkWell(
                                child: CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.remove),
                                ),
                                onTap: () {
                                  remover();
                                },
                              )),
                        InkWell(
                          child: CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.photo_camera),
                          ),
                          onTap: () {
                            _adicionar(context);
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ),
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
                      "Adicionar produto",
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
