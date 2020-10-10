import 'package:chalana_delivery/common/custon_icon_buttom.dart';
import 'package:chalana_delivery/models/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartTile(this.cartProduct);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product.images.first),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(cartProduct.product.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      Consumer<CartProduct>(
                        builder: (_, cartProduct, __) {
                          if (cartProduct.hasStock) {
                            return Text(
                                'R\$ ${cartProduct.product.price.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold));
                          } else {
                            return const Text(
                              'Sem estoque suficiente',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(builder: (_, cardProduct, __) {
                final isKilo =  cardProduct.product.price.hasPricePerKilo;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomIconButton(
                        iconData: Icons.add,
                        color: Theme.of(context).primaryColor,
                        onTap: cartProduct.increment,
                      ),
                      Text('${cartProduct.quantity} ${isKilo? '(kg)':''}',
                          style: const TextStyle(fontSize: 18)),
                      CustomIconButton(
                        iconData: Icons.remove,
                        color: cartProduct.quantity > 1
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                        onTap: cartProduct.decrement,
                      ),
                    ]);
              })
            ],
          ),
        ),
      ),
    );
  }
}
