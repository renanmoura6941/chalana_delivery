import 'package:chalana_delivery/models/section.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final Section section;

  const SectionHeader(this.section);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Text(section.name, style: TextStyle(color:Colors.white, fontWeight: FontWeight.w700,fontSize: 18),),
    );
  }
}
