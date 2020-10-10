class Produto {
  String nome;
  String descrissao;
  List<String> imagens;
  double preco;
  int acessos;
  String categorias;

  Produto(this.nome, this.preco,this.descrissao,this.imagens,this.acessos,this.categorias);


  @override
  String toString() {
    return "nome: $nome, descrissao: $descrissao,preco: $preco acessos: $acessos, categorias: $categorias, imagens: $imagens";
  }


}
