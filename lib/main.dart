import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:chalana_delivery/rotas/rotas.dart';
import 'package:chalana_delivery/telas/tela_cadastrar/tela_cadastrar.dart';
import 'package:chalana_delivery/telas/tela_editar_produto/tela_editar_produto.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  //Instanciar o repositorio.
  final GetIt getIt = GetIt.I;
  getIt.registerSingleton<Repositorio>(Repositorio());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    onGenerateRoute: Rotas.generateRoute,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Repositorio repo = GetIt.I.get<Repositorio>();

  @override
  void initState() {
    repo.getProdutos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TelaCadastrar();
  }
}
