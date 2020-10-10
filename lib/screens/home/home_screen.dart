import 'package:chalana_delivery/common/custom_drawer/custom_drawer.dart';
import 'package:chalana_delivery/models/home_manager.dart';
import 'package:chalana_delivery/models/section.dart';
import 'package:chalana_delivery/screens/home/components/SectionList.dart';
import 'package:chalana_delivery/screens/home/components/section_staggered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Container(
              color: const Color.fromARGB(255, 4, 125, 141),
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  snap: true,
                  floating: true,
                  flexibleSpace: const FlexibleSpaceBar(
                      title: Text('Chalana deliverry'), centerTitle: true),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cart');
                        })
                  ],
                ),
                Consumer<HomeManager>(
                  builder: (_, homeManeger, __) {
                    final List<Widget> children =
                        homeManeger.sections.map((sections) {
                      switch (sections.type) {
                        case 'List':
                          return SectionList(sections);
                        case 'staggered':
                          return SectionStaggered(sections);
                        default:
                          return Container();
                      }
                    }).toList();

                    return SliverList(
                        delegate: SliverChildListDelegate(children));
                  },
                )
              ],
            ),
          ],
        ));
  }
}
