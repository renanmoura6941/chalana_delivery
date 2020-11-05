import 'package:chalana_delivery/modelos/foto_modelo.dart';
import 'package:chalana_delivery/modelos/pedido_modelo.dart';
import 'package:chalana_delivery/modelos/produto_modelo.dart';
import 'package:chalana_delivery/telas/tela_carrinho/constants.dart';

class MockCarrinho {
  static List<PedidoModelo> pedidos_mock = [
    PedidoModelo(
      produto: ProdutoModelo(
        imagens: [FotoModelo(IMG_CERVEJA, "0")],
        nome: "Cerveja Corona",
        preco: 3.5,
      ),
      quantidade: 1,
    ),
    PedidoModelo(
      produto: ProdutoModelo(
        imagens: [FotoModelo(IMG_NOTEBOOK,"1")],
        nome: "Notebook",
        preco: 1999.99,
      ),
      quantidade: 3,
    ),
    PedidoModelo(
      produto: ProdutoModelo(
        imagens: [FotoModelo(IMG_CELULAR, "2")],
        nome: "Iphone 1200",
        preco: 70000,
      ),
      quantidade: 4,
    ),
  ];
}
