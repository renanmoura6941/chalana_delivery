import 'dart:async';
import 'package:chalana_delivery/modelos/carrinho_modelo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CarrinhoRegraNegocio {
  final StreamController<CarrinhoModelo> streamCarrinho = StreamController();
  final StreamController<CarrinhoModelo> streamPedido = StreamController();

  Sink<CarrinhoModelo> get entradaCarrinho => streamCarrinho.sink;
  Stream get saidaCarrinho => streamCarrinho.stream;

  Sink<CarrinhoModelo> get entradaPedido => streamPedido.sink;
  Stream get saidaPedido => streamPedido.stream;

  CarrinhoModelo carrinho = CarrinhoModelo();

  incrementar(int indice) {
    carrinho.listaPedidos[indice].quantidade++;
    entradaCarrinho.add(carrinho);
  }

  decrementar(int indice) {
    carrinho.listaPedidos[indice].quantidade--;
    entradaCarrinho.add(carrinho);
  }

  removerPedido(int indice) {
    carrinho.remover(indice);
    entradaCarrinho.add(carrinho);
  }

  Future<void> confirmarPedido() async {
    String q = "%0A";
    String divisor = "------------------------------------";
    double total = 0;
    String mensagem = "Minha solicitação:$q";

    for (var e in carrinho.listaPedidos) {
      mensagem +=
          "$divisor$q*Produto*: ${e.produto.nome}$q*Quantidade*: ${e.quantidade}$q*Preço da unidade*: R\$ ${e.produto.preco.toStringAsFixed(2)}$q*Valor*: R\$ ${(e.quantidade * e.produto.preco).toStringAsFixed(2)}$q";
      total += e.quantidade * e.produto.preco;
    }

    mensagem += divisor +
        q +
        q +
        q +
        "*Preço total da solicitação*: ${total.toStringAsFixed(2)}";

    String url =
        "https://api.whatsapp.com/send/?phone=5585992954232&text=${mensagem}&app_absent=0";

    try {
      await launch(url);
      carrinho.limpar();
      entradaCarrinho.add(carrinho);
    } catch (erro) {
      debugPrint("erro ao enviar mensagem: $erro");
    }
  }
}
