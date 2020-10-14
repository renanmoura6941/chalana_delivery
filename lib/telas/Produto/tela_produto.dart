import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class TelaProduto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imagens = [
      "https://delivery.supermuffato.com.br/arquivos/ids/258950-1000-1000/7897395099329.jpg?v=637127241430430000",
      "https://www.imigrantesbebidas.com.br/bebida/images/products/full/222_Cerveja_Heineken_Long_Neck_330_ml.jpg"
         ];

    return Scaffold(
      appBar: AppBar(title: Text("Cerveja"), centerTitle: true,),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              dotSize: 4,
              //dotBgColor: Colors.transparent,
              autoplay: false,
                images: imagens.map((url) {
              return NetworkImage(url);
            }).toList()),
          )
        ],
      ),
    );
  }
}
