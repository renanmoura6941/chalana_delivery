import 'package:flutter/material.dart';

class Secao extends StatelessWidget {
  final String section;

  const Secao(this.section);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Text(section, style: TextStyle(color:Colors.white, fontWeight: FontWeight.w700,fontSize: 18),),
    );
  }
}
