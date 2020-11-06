import 'package:chalana_delivery/modulos/menu/tela_menu.dart';
import 'package:chalana_delivery/repositorio/repositorio.dart';
import 'package:chalana_delivery/rotas/rotas.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'modelos/pedido_modelo.dart';

void main() {
  //Instanciar o repositorio.
  final GetIt getIt = GetIt.I;
  getIt.registerSingleton<Repositorio>(Repositorio());
  getIt.registerSingleton<List<PedidoModelo>>(List<PedidoModelo>());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    onGenerateRoute: Rotas.generateRoute,
    theme: ThemeData(
      primaryColor: const Color.fromARGB(255, 4, 125, 141),
      scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
      appBarTheme: const AppBarTheme(elevation: 0),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TelaMenu();
  }
}
