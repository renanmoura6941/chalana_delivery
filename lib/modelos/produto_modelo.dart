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

  salvar() async {
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

    print("ID $id");
    await referencia.updateData(dados);
  }

  @override
  String toString() {
    return "id: $id, nome: $nome, descrissao: $descrissao,preco: $preco acessos: $acessos, categorias: $categorias, imagens: $imagens";
  }
}
