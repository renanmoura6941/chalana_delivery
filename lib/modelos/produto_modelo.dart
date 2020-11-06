import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoModelo {
  String id;
  String nome;
  String descrissao;
  List<FotoModelo> imagens;
  num preco;
  int acessos;
  String categorias;

  ProdutoModelo({
    this.id,
    this.nome,
    this.preco,
    this.descrissao,
    this.imagens,
    this.acessos,
    this.categorias,
  });

  copiar() {
    return ProdutoModelo(
        id: this.id,
        nome: this.nome,
        preco: this.preco,
        descrissao: this.descrissao,
        imagens: this.imagens.map((e) => e.copiar()).toList(),
        acessos: this.acessos,
        categorias: this.categorias);
  }

  salvar() async {
    print("salvando produto no firebase......");
    var dados = {
      'id': id,
      'nome': nome,
      'preco': preco,
      'categorias': categorias,
      'imagens': imagens.map((e) => e.toMap()).toList(),
      'descrissao': descrissao,
      'acessos': acessos,
    };
    final referencia =
        await Firestore.instance.collection('produtos').add(dados);

    id = referencia.documentID;
    dados['id'] = id;

    await referencia.updateData(dados);

    print("salvo produto $nome no firebase SUCESSO(V)");
  }

  atualizar() async {
    print("atualizando produto $nome no firebase......");

    var dados = {
      'nome': nome,
      'preco': preco,
      'categorias': categorias,
      'imagens': imagens.map((e) => e.toMap()).toList(),
      'descrissao': descrissao,
    };

    await Firestore.instance
        .collection('produtos')
        .document(id)
        .updateData(dados);

    print("atualizado produto $nome no firebase SUCESSO(V)");
  }

  remover() async {
    await Firestore.instance
      ..collection('produtos').document(id).delete();
  }

  @override
  String toString() {
    return "id: $id, nome: $nome, descrissao: $descrissao,preco: $preco acessos: $acessos, categorias: $categorias, imagens: $imagens";
  }
}
