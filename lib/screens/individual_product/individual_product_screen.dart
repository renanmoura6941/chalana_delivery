import 'package:carousel_pro/carousel_pro.dart';
import 'package:chalana_delivery/models/cart_manager.dart';
import 'package:chalana_delivery/models/product.dart';
import 'package:chalana_delivery/models/user_manager.dart';
import 'package:chalana_delivery/screens/individual_product/components/input_slide_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndividualProductScreen extends StatelessWidget {
  final Product product;
  const IndividualProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    //MY
    if (product.price.hasPricePerKilo) product.stateInital();
    //MYEND

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
        ),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.5,
                child: Carousel(
                  images: product.images.map((url) {
                    return NetworkImage(url);
                  }).toList(),
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.grey,
                  dotIncreasedColor: product.images.length > 1
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),

                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('A partir de',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                      ),

                      Consumer<Product>(
                        builder: (_, product, __) {
                          return RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'R\$ ${product.price.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context).primaryColor)),
                                /*kilo*/ if (product.price.hasPricePerKilo)
                                  TextSpan(
                                    text:
                                        ' (kg)',
                                    style: TextStyle(
                                     // fontStyle: FontStyle.italic,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context).primaryColor),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: Text('Descrição',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                      ),

                      Text(product.description,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          )),

                      // // //CURSO
                      // //____________________________

                      //____________________________

                      const SizedBox(height: 20),

                      /*kilo*/ if (product.hasStock)
                        Consumer2<UserManager, Product>(
                          builder: (_, userManager, product, __) {
                            return SizedBox(
                                height: 44,
                                child: RaisedButton(
                                  onPressed: () {
                                    if (userManager.isLogged) {
                                      //TODO: ADICIONAR AO CARRINHO
                                      context.read<CartManager>().addToCart(product);
                                      Navigator.of(context).pushNamed('/cart');

                                    } else {
                                      Navigator.of(context).pushNamed('/login');
                                   
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: Text(
                                      userManager.isLogged
                                          ? 'Adicionar ao carrinho'
                                          : 'Entre para comprar',
                                      style: const TextStyle(fontSize: 18)),
                                ));
                          },
                        ),
                      // //CURSOEND

                      //MY

                      const SizedBox(height: 20),

                      //MYEND
                    ]),
              )
            ],
          ),
          
        ),
        
      ),
    );
  }
}
