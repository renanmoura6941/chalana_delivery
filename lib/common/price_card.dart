import 'package:chalana_delivery/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PriceCard({Key key, this.buttonText, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productPrice;
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Resumo do pedido',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Subtotal'),
                   Text('R\$ ${productsPrice.toStringAsFixed(2)}'),
                 
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Total', style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('R\$ ${productsPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16)),
                ],
              ),
             const Divider(),
              const SizedBox(height: 8),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: onPressed,
                child:  Text(buttonText),
              )
            ],
          ),
        ));
  }
}
