import 'package:chalana_delivery/models/section.dart';
import 'package:chalana_delivery/screens/home/components/SectionHeader.dart';
import 'package:chalana_delivery/screens/home/components/item_tile.dart';
import 'package:flutter/material.dart';

class SectionList extends StatelessWidget {
  final Section section;

  const SectionList(this.section);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(section),
            SizedBox(
              height: 150,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                     return ItemTile(section.items[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(
                        height: 4,
                      ),
                  itemCount: section.items.length),
            )
          ]),
    );
  }
}
