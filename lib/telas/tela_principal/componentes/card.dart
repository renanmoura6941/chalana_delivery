import 'package:chalana_delivery/helpers/api_whats_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';


class CardPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "produto");
        
      },
      child: Container(
        
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
      ),
    );
  }
}
