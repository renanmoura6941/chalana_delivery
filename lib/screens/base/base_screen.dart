import 'package:chalana_delivery/common/custom_drawer/custom_drawer.dart';
import 'package:chalana_delivery/models/page_manager.dart';
import 'package:chalana_delivery/screens/home/home_screen.dart';
import 'package:chalana_delivery/screens/products/productsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home3'),
            ),
          ),
        ],
      ),
    );
  }
}
