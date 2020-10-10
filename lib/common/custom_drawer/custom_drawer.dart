import 'package:chalana_delivery/common/custom_drawer/custom_drawer_header.dart';
import 'package:chalana_delivery/common/custom_drawer/drawer_tile.dart';
import 'package:chalana_delivery/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.white,
                Colors.white,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          ListView(children: <Widget>[
            CustomDrawerHeader(),
            const Divider(),
            const DrawerTitle(
              iconData: Icons.home,
              title: 'Início',
              page: 0,
            ),
            const DrawerTitle(
              iconData: Icons.list,
              title: 'Produtos',
              page: 1,
            ),
            const DrawerTitle(
              iconData: Icons.playlist_add_check,
              title: 'Meus pedidos',
              page: 2,
            ),
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return Column(
                    children: <Widget>[
                      Divider(),
                      const DrawerTitle(
                        iconData: Icons.settings,
                        title: 'usuários',
                        page: 3,
                      ),
                    ],
                  );
                }
                return Container();
              },
            )
          ]),
        ],
      ),
    );
  }
}
