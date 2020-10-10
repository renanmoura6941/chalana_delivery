import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:chalana_delivery/telas/tela_principal.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  //Instanciar o repositorio.
  final GetIt getIt = GetIt.I;
  getIt.registerSingleton(() => Repositorio());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return TelaPrincipal();
  }
}
