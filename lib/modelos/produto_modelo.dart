class ProdutoModelo {
  final String nome;
  final String descrissao;
  final List<String> imagens;
  final double preco;
  final int acessos;
  final String categorias;

  const ProdutoModelo(this.nome, this.preco, this.descrissao, this.imagens,
      this.acessos, this.categorias);

  @override
  String toString() {
    return "nome: $nome, descrissao: $descrissao,preco: $preco acessos: $acessos, categorias: $categorias, imagens: $imagens";
  }
}
