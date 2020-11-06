
import 'package:chalana_delivery/modulos/adicionar_produto/tela_adicionar_produto.dart';
import 'package:chalana_delivery/modulos/carrinho/tela_carrinho.dart';
import 'package:chalana_delivery/modulos/editar_produto/tela_editar_produto.dart';
import 'package:chalana_delivery/modulos/menu/tela_menu.dart';
import 'package:chalana_delivery/modulos/principal/tela_principal.dart';
import 'package:chalana_delivery/modulos/produto/tela_produto.dart';
import 'package:flutter/material.dart';

class Rotas {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final Map<String, dynamic> routes = {
     // "login": MaterialPageRoute(builder: (_) => TelaLogin()),
      "tela_menu": MaterialPageRoute(builder: (_) => TelaMenu()),
      "produto": MaterialPageRoute(builder: (_) => TelaProduto(args)),
      "tela_editar_produto":
          MaterialPageRoute(builder: (_) => TelaEditarProduto(args)),
      "tela_adicionar_produto":
          MaterialPageRoute(builder: (_) => TelaAdicionarProduto()),
      "Tela_carrinho": MaterialPageRoute(builder: (_) => TelaCarrinho()),
      "principal": MaterialPageRoute(builder: (_) => TelaPrincipal()),
    };
    if (routes.containsKey(settings.name)) {
      return routes[settings.name];
    } else {
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                'ERROR',
                //textScaleFactor: 0.98,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "Mensagem desenvolvedor:",
                //textScaleFactor: 0.98,
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                "Erro na rota",
                //textScaleFactor: 0.98,
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ),
      );
    });
  }
}
