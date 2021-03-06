import 'dart:async';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class AtualizarProduto {
  final StreamController<List<ProdutoModelo>> streamAtualizarProduto =
      StreamController();
  Sink<List<ProdutoModelo>> get entrada => streamAtualizarProduto.sink;
  Stream get saida => streamAtualizarProduto.stream;
  bool inicio = true;

  escultarAlteracoes() async {
    await Firestore.instance
        .collection('produtos')
        .snapshots()
        .listen((_) async {
      print("Escutando alterações do Firebase");
      final produtos = await GetIt.I.get<Repositorio>().getProdutos();
      print("total de produtos atualizados:${produtos.length}");
      inicio = false;
      entrada.add(produtos);
    });
  }

  destruir() {
    streamAtualizarProduto.close();
  }
}
