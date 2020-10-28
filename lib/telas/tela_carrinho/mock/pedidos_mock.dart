import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/telas/tela_carrinho/constants.dart';

class MockCarrinho {
  static List<PedidoModelo> pedidos_mock = [
    PedidoModelo(
      produto: ProdutoModelo(
        imagens: [IMG_CERVEJA],
        nome: "Cerveja Corona",
        preco: 3.5,
      ),
      quantidade: 1,
    ),
    PedidoModelo(
      produto: ProdutoModelo(
        imagens: [IMG_NOTEBOOK],
        nome: "Notebook",
        preco: 1999.99,
      ),
      quantidade: 3,
    ),
    PedidoModelo(
      produto: ProdutoModelo(
        imagens: [IMG_CELULAR],
        nome: "Iphone 1200",
        preco: 70000,
      ),
      quantidade: 4,
    ),
  ];
}
