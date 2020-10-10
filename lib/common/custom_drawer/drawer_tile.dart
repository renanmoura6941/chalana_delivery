import 'package:chalana_delivery/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTitle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page;

  const DrawerTitle({Key key, this.iconData, this.title, this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //obter página atual
    final int curPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        //acessar o page de qualquer local alternar de página
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    color: curPage == page ?primaryColor : Colors.grey[700]))
          ],
        ),
      ),
    );
  }
}
