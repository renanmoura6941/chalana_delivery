import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaProduto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imagens = [
      "https://delivery.supermuffato.com.br/arquivos/ids/258950-1000-1000/7897395099329.jpg?v=637127241430430000",
      "https://www.imigrantesbebidas.com.br/bebida/images/products/full/222_Cerveja_Heineken_Long_Neck_330_ml.jpg"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Cerveja"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              dotSize: 6,
              //dotBgColor: Colors.transparent,
              autoplay: false,
              images: imagens.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotIncreasedColor: Colors.blue,
              dotBgColor: Colors.transparent,
              dotColor: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "product.name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'A partir de',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  'R\$ 19.99',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    // color: primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  "product.description",
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Adicionar ao carrinho",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      var produto = {
                        'nome': "Cerveja da boa",
                        'quantidade': 4,
                        'unidade': 2.00,
                        'valor': 8.00
                      };
                      var produto2 = {
                        'nome': "vinho especial",
                        'quantidade': 10,
                        'unidade': 2.00,
                        'valor': 20.00
                      };

                      List<Map> dados = [produto, produto2];

                     
                      String q = "%0A";
                      String divisor = "------------------------------------";
                      double total = 0;
                       String mensagem = "Minha solicitação:$q";
                      for (var e in dados) {
                        mensagem +=
                            "$divisor$q*Produto*: ${e['nome']}$q*Quantidade*: ${e['quantidade']}$q*Preço da unidade*: R\$ ${e['unidade'].toStringAsFixed(2)}$q*Valor*: R\$ ${e['valor'].toStringAsFixed(2)}$q";
                     total +=e['valor'];
                     
                      }

                      mensagem+=divisor+q+q+q+"*Preço total da solicitação*: ${total.toStringAsFixed(2)}";

                      String url =
                          "https://api.whatsapp.com/send/?phone=5585992954232&text=${mensagem}&app_absent=0";

                      try {
                        await launch(url);
                      } catch (erro) {
                        debugPrint("erro ao enviar mensagem: $erro");
                      }

                      //Navigator.pushNamed(context, "carrinho");
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
