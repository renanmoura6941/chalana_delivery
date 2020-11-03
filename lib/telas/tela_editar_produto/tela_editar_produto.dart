import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/componentes/butao_confirmar/butao_confirmar.dart';
import 'package:chalana_delivery/helpers/validators_functions.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/componetes/selecionar_imagem.dart';
import 'package:chalana_delivery/telas/tela_adicionar_produto/modelo/Imagem_selecionar_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
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
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<String> imagens = [];
  List<ImagemModelo> imagemModelo = [];

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

  Widget butaoTirarFoto() {
    return InkWell(
        child: CircleAvatar(
          radius: 30,
          child: Icon(Icons.photo_camera),
        ),
        onTap: () => imagemModelo.length > 2
            ? popAlerta(context, "Limite máximo de fotos!")
            : _adicionar(context));
  }

  List<Widget> abirImagens() {
    return List<Widget>.generate(imagemModelo.length, (index) {
      return GestureDetector(
        onLongPress: () => setState(() {
          imagemModelo[index].selecionado = !imagemModelo[index].selecionado;
        }),
        child: ImagemWidget(
            imagem: imagemModelo[index].imagem,
            imagemUrl: imagemModelo[index].imagemUrl,
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

  void carregarDadosProduto() {
    nomeController.text = widget.produtoModelo.nome;
    precoController.text = widget.produtoModelo.preco.toStringAsFixed(2);
    descricaoController.text = widget.produtoModelo.descrissao;
    widget.produtoModelo.imagens.forEach((e) {
      imagemModelo.add(ImagemModelo(
        imagemUrl: e,
      ));
    });
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
                      temItemSelecionado() ? butaoRemover() : butaoTirarFoto()),
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
                    validator: (valor) => validarNome(valor),
                  ),
                  Text("Preço"),
                  TextFormField(
                    controller: precoController,
                    validator: (valor) => validarPreco(valor),
                  ),
                  Text("Descrição"),
                  TextFormField(
                    controller: descricaoController,
                    validator: (valor) => validarDescricao(valor),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ButaoConfirmar(
                      titulo: "Editar produto",
                      onPressed: () {
                        //TODO:validar
                        if (formkey.currentState.validate() &&
                            validarFoto(imagemModelo, context)) {}
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
