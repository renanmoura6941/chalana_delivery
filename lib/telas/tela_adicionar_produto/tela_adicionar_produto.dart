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
import 'package:uuid/uuid.dart';

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
  ProdutoModelo produtoModelo = ProdutoModelo();
  bool processando = false;

  Future<String> salvarImagemFirebase(File imagem) async {
    var storageRef = FirebaseStorage.instance.ref().child(produtoModelo.nome);

    final StorageUploadTask task =
        storageRef.child(Uuid().v1()).putFile(imagem);

    final StorageTaskSnapshot snapshot = await task.onComplete;
    final String url = await snapshot.ref.getDownloadURL() as String;

    return url;
  }

  void salvarFirebase() async {
    for (final e in imagemModelo) {
      String url = await salvarImagemFirebase(e.imagem);
      print("url recuperada $url");
      produtoModelo.imagens.add(url);
    }
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
    produtoModelo.imagens = [];
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
                  child: temItemSelecionado()
                      ? butaoRemover()
                      : butaoTirarFoto(context)),
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
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) => produtoModelo.nome = entrada),
                  Text("Preço"),
                  TextFormField(
                      controller: precoController,
                      validator: (preco) => validarPreco(preco),
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) =>
                          produtoModelo.preco = num.parse(entrada)),
                  Text("Descrição"),
                  TextFormField(
                      controller: descricaoController,
                      validator: (descricao) => validarDescricao(descricao),
                      onChanged: (entrada) => formkey.currentState.validate(),
                      onSaved: (entrada) => produtoModelo.descrissao = entrada),
                  SizedBox(
                    height: 30,
                  ),
                  processando
                      ? CircularProgressIndicator()
                      : ButaoConfirmar(
                          titulo: "Adicionar produto",
                          onPressed: () async {
                            if (formkey.currentState.validate() &&
                                validarFoto(imagemModelo, context)) {
                              setState(() {
                                processando = true;
                              });
                              formkey.currentState.save();

                              await salvarFirebase();

                              produtoModelo.salvar();
                              Navigator.pushReplacementNamed(context, "principal");
                           
                            }
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
