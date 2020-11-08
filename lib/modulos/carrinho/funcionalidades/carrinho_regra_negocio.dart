import 'dart:async';
import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/helpers/conexao.dart';
import 'package:chalana_delivery/modelos/carrinho_modelo.dart';
import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CarrinhoRegraNegocio {
  final StreamController<CarrinhoModelo> streamCarrinho = StreamController();

  Sink<CarrinhoModelo> get entradaCarrinho => streamCarrinho.sink;
  Stream get saidaCarrinho => streamCarrinho.stream;
  CarrinhoModelo carrinho = CarrinhoModelo();

  final StreamController<bool> streamNoCarrinho = StreamController();
  Sink<bool> get entradaNoCarrinho => streamNoCarrinho.sink;
  Stream get saidaNoCarrinho => streamNoCarrinho.stream;
  bool noCarrinho = false;

  estaNoCarrinho(ProdutoModelo produto) {
    noCarrinho = carrinho.listaPedidos.contains(produto);
    entradaNoCarrinho.add(noCarrinho);
  }

  incrementar(int indice) {
    carrinho.listaPedidos[indice].quantidade++;
    entradaCarrinho.add(carrinho);
  }

  decrementar(int indice) {
    carrinho.listaPedidos[indice].quantidade--;
    entradaCarrinho.add(carrinho);
  }

  removerPedido(int indice) {
    carrinho.listaPedidos.removeAt(indice);
    entradaCarrinho.add(carrinho);
  }

  void adicionar(PedidoModelo pedido) {
    carrinho.listaPedidos.add(pedido);
  }

  limpar() {
    carrinho.listaPedidos.clear();
  }

  Future<void> confirmarPedido(BuildContext context) async {
    if (await temInternet()) {
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
      String numero = "5585997732024";
      String url =
          "https://api.whatsapp.com/send/?phone=$numero&text=${mensagem}&app_absent=0";

      try {
        await launch(url);
        limpar();
        entradaCarrinho.add(carrinho);
      } catch (erro) {
        debugPrint("erro ao enviar mensagem: $erro");
      }
    }else{
      popAlerta(context, "Ops!...Sem conexão com a internet");
    }
  }
}
