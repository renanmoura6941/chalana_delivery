import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaAnimacao extends StatefulWidget {
  final bool automatico;

  const TelaAnimacao({Key key, this.automatico = false}) : super(key: key);
  @override
  _TelaAnimacaoState createState() => _TelaAnimacaoState();
}

class _TelaAnimacaoState extends State<TelaAnimacao> {
  List<ProdutoModelo> produtos;

  pegarProdutos() async {
    produtos = await GetIt.I.get<Repositorio>().getProdutos();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, "tela_menu", (route) => false);
    });
  }

  @override
  void initState() {
    pegarProdutos();

    GetIt.I.get<Repositorio>().getProdutos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: COR_PRINCIPAL.withOpacity(0.6),
      child: Center(
        
        child: Column(
          children: [
            Image.asset(
              "lib/imagens/logo2.png",
              color: Colors.white,
            ),
            CARREGANDO
          ],
        ),
      ),
    );
  }
}
