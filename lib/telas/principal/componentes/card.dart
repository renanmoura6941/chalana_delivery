import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.7,
            child: Image.network(
              "https://www.imigrantesbebidas.com.br/bebida/images/products/full/222_Cerveja_Heineken_Long_Neck_330_ml.jpg",
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Text('Prouto x sfdws fsdfads ewer wsfer afd',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
          Text(
            "R\$ 19,99",
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
