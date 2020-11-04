import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:chalana_delivery/telas/tela_principal/componentes/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  Widget gridView(List<ProdutoModelo> produtos) {
    return GridView.count(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10),
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: produtos.map((elemeto) {
          return CardPrincipal(elemeto);
        }).toList());
  }

  atualizar() async {
    await Firestore.instance.collection('produtos').snapshots().listen((event) {
      print("escultando");
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    super.dispose();
  }

  @override
  void initState() {
    atualizar();
    GetIt.I.get<Repositorio>().getProdutos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chalana delivery",
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: FutureBuilder(
              future: GetIt.I.get<Repositorio>().getProdutos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return gridView(snapshot.data);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      )),
    );
  }
}
