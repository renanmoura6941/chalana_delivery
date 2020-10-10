import 'package:chalana_delivery/telas/tela_principal.dart';
import 'package:flutter/material.dart';

void main() {
  // final GetIt getIt = GetIt.I;

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
