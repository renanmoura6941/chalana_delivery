import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repositorio {
  List<FotoModelo> _mapImg(List doc) {
    return doc.map((e) {
      return FotoModelo(e['url'], e['uuid']);
    }).toList();
  }

  Future<List<ProdutoModelo>> getProdutos() async {
    print("pegar produtos Firebase");
    final querySnapshot = await Firestore.instance
        .collection('produtos')
        .orderBy("acessos", descending: true)
        .getDocuments();
    print("pegar produtos Firebase (V)SUCESSO!");

    return querySnapshot.documents.map((doc) {
      return ProdutoModelo(
        id: doc.documentID,
        nome: doc['nome'].toString(),
        preco: doc['preco'],
        categorias: doc['categoria'].toString(),
        imagens: _mapImg(doc['imagens']),
        descrissao: doc['descrissao'].toString(),
        acessos: doc['acessos'] as int,
      );
    }).toList();
  }
}
