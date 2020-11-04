import 'dart:async';

import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:chalana_delivery/telas/tela_principal/bloc.dart';
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

  Bloc bloc = Bloc();
  @override
  void initState() {
    // TODO: implement initState

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
            child: FutureBuilder<List<ProdutoModelo>>(
                future: GetIt.I.get<Repositorio>().getProdutos(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    bloc.escultar();
                    return StreamBuilder<List<ProdutoModelo>>(
                      initialData: snapshot.data,
                      stream: bloc.saida,
                      builder: (context, snapshot) {
                        //print("REBUIL dados:${snapshot.data}");
                        print("Construindo a tela de Produtos");

                        if (snapshot.hasData) {
                          return gridView(snapshot.data);
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })),
      )),
    );
  }
}
