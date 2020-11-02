import 'package:chalana_delivery/telas/tela_adicionar_produto/tela_adicionar_produto.dart';
import 'package:chalana_delivery/telas/tela_cadastrar/tela_cadastrar.dart';
import 'package:chalana_delivery/telas/tela_carrinho/tela_carrinho.dart';
import 'package:chalana_delivery/telas/tela_editar_produto/tela_editar_produto.dart';
import 'package:chalana_delivery/telas/tela_login/tela_login.dart';
import 'package:chalana_delivery/telas/tela_principal/tela_principal.dart';
import 'package:chalana_delivery/telas/tela_produto/tela_produto.dart';
import 'package:flutter/material.dart';

class Rotas {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final Map<String, dynamic> routes = {
      "login": MaterialPageRoute(builder: (_) => TelaLogin()),
      "cadastro": MaterialPageRoute(builder: (_) => TelaCadastrar()),
      "produto": MaterialPageRoute(builder: (_) => TelaProduto(args)),
      "tela_editar_produto":
          MaterialPageRoute(builder: (_) => TelaEditarProduto(args)),
      "tela_adicionar_produto":
          MaterialPageRoute(builder: (_) => TelaAdicionarProduto()),
      "carrinho": MaterialPageRoute(builder: (_) => TelaCarrinho()),
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
