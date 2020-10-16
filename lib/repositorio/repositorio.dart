import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repositorio {
  Future<List<ProdutoModelo>> getProdutos() async {
    final querySnapshot = await Firestore.instance
        .collection('produtos')
        .orderBy("acessos", descending: true)
        .getDocuments();

    return querySnapshot.documents.map((doc) {
      return ProdutoModelo(
        nome: doc['nome'].toString(),
        preco: doc['preco'].toDouble(),
        categorias: doc['categoria'].toString(),
        imagens: (doc['imagens'] as List).map((e) => e.toString()).toList(),
        descrissao: doc['descrissao'].toString(),
        acessos: doc['acessos'] as int,
      );
    }).toList();
  }
}
