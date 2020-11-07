import 'package:chalana_delivery/helpers/alertas.dart';
import 'package:flutter/material.dart';

class TelaAnimacao extends StatefulWidget {
  @override
  _TelaAnimacaoState createState() => _TelaAnimacaoState();
}

class _TelaAnimacaoState extends State<TelaAnimacao> {
  @override
  void initState() {
   Future.delayed(Duration(seconds: 3),(){
     Navigator.pushNamedAndRemoveUntil(context, "principal", (route) => false);

   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.6),
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
