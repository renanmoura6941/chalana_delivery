class ProdutoModelo {
  final String id;
  final String nome;
  final String descrissao;
  final List<String> imagens;
  final double preco;
  final int acessos;
  final String categorias;

  const ProdutoModelo({this.id, 
    this.nome,
    this.preco,
    this.descrissao,
    this.imagens,
    this.acessos,
    this.categorias,
  });

  @override
  String toString() {
    return "id: $id, nome: $nome, descrissao: $descrissao,preco: $preco acessos: $acessos, categorias: $categorias, imagens: $imagens";
  }
}
