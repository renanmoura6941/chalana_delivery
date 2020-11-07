import 'package:chalana_delivery/modulos/animacao/tela_animacao.dart';
import 'package:chalana_delivery/modulos/carrinho/tela_carrinho.dart';
import 'package:chalana_delivery/modulos/principal/tela_principal.dart';

import 'package:flutter/material.dart';

class TelaMenu extends StatefulWidget {
  int indice;

   TelaMenu({Key key, this.indice}) : super(key: key);
  @override
  _TelaMenuState createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  List<Widget> telas = [TelaPrincipal(), TelaAnimacao()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telas.elementAt(_selectedIndex),
    );
  }
}
