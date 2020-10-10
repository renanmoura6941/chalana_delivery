import 'package:chalana_delivery/common/custom_drawer/custom_drawer.dart';
import 'package:chalana_delivery/models/product_manager.dart';
import 'package:chalana_delivery/screens/products/components/product_list_tile.dart';
import 'package:chalana_delivery/screens/products/components/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(builder: (_, productManager, __) {
          if (productManager.search.isEmpty) {
            return const Text('Produtos');
          } else {
            return LayoutBuilder(builder: (_, constraints) {
              return GestureDetector(
                onTap: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(productManager.search));
                  if (search != null) {
                    productManager.search = search;
                  }
                },
                child: Container(
                    width: constraints.biggest.width,
                    child: Text(productManager.search)),
              );
            });
          }
        }),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(productManager.search));
                      if (search != null) {
                        productManager.search = search;
                      }
                    });
              } else {
                return IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      productManager.search = '';
                    });
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filtredProducts = productManager.filtredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: filtredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(filtredProducts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(

          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).primaryColor,
          onPressed: (){
            Navigator.of(context).pushNamed('/cart');

          },
          child: Icon(Icons.shopping_cart),
        ),
    );
  }
}
