import 'dart:async';

import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class Bloc {
  final StreamController<List<ProdutoModelo>> stream = StreamController();
  Sink<List<ProdutoModelo>> get entrada => stream.sink;
  Stream get saida => stream.stream;

  escultar() async {
    await Firestore.instance
        .collection('produtos')
        .snapshots()
        .listen((_) async {
      print("Escutando alterações do Firebase");
      final produtos = await GetIt.I.get<Repositorio>().getProdutos();
      print("total de produtos atualizados:${produtos.length}");

      entrada.add(produtos);
    });
  }
}
