import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String section;

  const SectionHeader(this.section);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Text(section, style: TextStyle(color:Colors.white, fontWeight: FontWeight.w700,fontSize: 18),),
    );
  }
}
