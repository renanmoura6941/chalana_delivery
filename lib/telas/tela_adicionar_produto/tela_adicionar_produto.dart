import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/componentes/butao_confirmar/butao_confirmar.dart';
import 'package:chalana_delivery/helpers/validators_functions.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/componetes/selecionar_imagem.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/modelo/Imagem_selecionar_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TelaAdicionarProduto extends StatefulWidget {
  @override
  _TelaAdicionarProdutoState createState() => _TelaAdicionarProdutoState();
}

class _TelaAdicionarProdutoState extends State<TelaAdicionarProduto> {
  List<ImagemModelo> imagemModelo;
  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> recuperarImagemFirebase(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
  }

  Future salvarImagemFirebase(File imagem) async {
    StorageReference pastaraiz = FirebaseStorage.instance.ref();
    StorageReference arquivo = pastaraiz.child("prdutos").child("foto.jpg");
    StorageUploadTask task = arquivo.putFile(imagem);

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
      recuperarImagemFirebase(snapshot);
    });
  }

  Future _imagenCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null)
      setState(() {
        imagemModelo.add(ImagemModelo(imagem: File(pickedFile.path)));
      });
  }

  Future _imagenGaleria() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null)
      setState(() {
        imagemModelo.add(ImagemModelo(imagem: File(pickedFile.path)));
      });
  }

  Widget butaoRemover() {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.remove),
        ),
        onTap: () => remover());
  }

  Widget butaoTirarFoto(BuildContext context) {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.photo_camera),
        ),
        onTap: () =>
            imagemModelo.length > 2 ? popAlerta(context,"Limite máximo de fotos!") : _adicionar(context));
  }

  List<Widget> abirImagens() {
    return List<Widget>.generate(imagemModelo.length, (index) {
      return GestureDetector(
        onLongPress: () => setState(() {
          imagemModelo[index].selecionado = !imagemModelo[index].selecionado;
        }),
        child: ImagemWidget(
            imagem: imagemModelo[index].imagem,
            selecionado: imagemModelo[index].selecionado),
      );
    });
  }

  void _adicionar(BuildContext context) {
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

  void remover() {
    imagemModelo.removeWhere((e) => e.selecionado);
    setState(() {});
  }


  int itemselecionados() => imagemModelo.where((e) => e.selecionado).length;

  bool temItemSelecionado() => itemselecionados() > 0 ? true : false;

  @override
  void initState() {
    imagemModelo = [];
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
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  dotSize: 6,
                  autoplay: false,
                  dotIncreasedColor: Colors.blue,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.blue,
                  images: imagemModelo.isEmpty
                      ? [
                          Icon(
                            Icons.photo,
                            size: 100,
                          )
                        ]
                      : abirImagens(),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child:
                      temItemSelecionado() ? butaoRemover() :popAlerta(context,"Limite máximo de fotos!")),
              if (temItemSelecionado())
                Positioned(
                    bottom: 0,
                    left: 7,
                    child: FloatingActionButton.extended(
                      onPressed: null,
                      label: Text("${itemselecionados()} item selecionado",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nome"),
                  TextFormField(
                    controller: nomeController,
                    validator: (nome) => validarNome(nome),
                  ),
                  Text("Preço"),
                  TextFormField(
                    controller: precoController,
                    validator: (preco) => validarPreco(preco),
                  ),
                  Text("Descrição"),
                  TextFormField(
                    controller: descricaoController,
                    validator: (descricao) => validarDescricao(descricao),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ButaoConfirmar(
                      titulo: "Adicionar produto",
                      onPressed: () {
                        //TODO:validar
                        if (formkey.currentState.validate() &&
                            validarFoto(imagemModelo,context)){

                            }
                        //TODO:salvar no firebase
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// sDialog() {
//   SimpleDialog _simdalog = SimpleDialog(
//     title: new Text("Add To Shopping Cart"),
//     children: <Widget>[
//       new SimpleDialogOption(
//         child: new Text("Yes"),
//         onPressed: () {
//           final snackBar = SnackBar(content: Text('Purchase Successful'));
//           Scaffold.of(context).showSnackBar(snackBar);
//         },
//       ),
//       new SimpleDialogOption(
//         child: new Text("Close"),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     ],
//   );
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return _simdalog;
//       });
// }
