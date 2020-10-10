
import 'package:chalana_delivery/models/product_manager.dart';
import 'package:chalana_delivery/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {

  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(item.product != null){
          final product = context.read<ProductManager>()
              .findProductById(item.product);
          if(product != null){
            Navigator.of(context).pushNamed('/IndividualProductScreen', arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}