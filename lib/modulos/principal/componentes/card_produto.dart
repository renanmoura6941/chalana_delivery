import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:flutter/material.dart';

class CardProduto extends StatelessWidget {
  ProdutoModelo produtoModelo;
  CardProduto(this.produtoModelo);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "produto",
            arguments: produtoModelo.copiar());
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(produtoModelo.imagens.first.url),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      produtoModelo.nome,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ${produtoModelo.preco.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
