import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

class PeodutoRegraNegocio {
  bool noCarrinho;
  ProdutoModelo produto;
  PeodutoRegraNegocio(this.produto);

  estaNoCarrinho(ProdutoModelo produto) {
    var carrinho = GetIt.I.get<List<PedidoModelo>>();
    noCarrinho = false;
    carrinho.forEach((e) {
      if (e.produto.id == produto.id) {
        noCarrinho = true;
      }
    });
    print("produto esta no carrinho: $noCarrinho");
  }

  Future<void> removerImagemStorege() async {
    var referencia = await FirebaseStorage.instance.ref().child(produto.id);

    produto.imagens.forEach((e) async {
      await referencia.child(e.uuid).delete();
    });
  }

  Future<void> remover() async {
    await removerImagemStorege();
    await produto.remover();
  }

  addCarrinho(ProdutoModelo produto) {
    var carrinho = GetIt.I.get<List<PedidoModelo>>();
    carrinho.add(PedidoModelo(produto: produto));
  }
}
