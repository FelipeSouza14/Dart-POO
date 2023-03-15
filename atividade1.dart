class Produto{
  double preco;
  String nome;
  
  Produto({required this.nome, required this.preco});
  
  String toString() => "$nome\nPreco: $preco";
  
}


class Item{
  Produto produto;
  double quantidade;
  
  Item({required this.produto, required this.quantidade});
    
  double totalItem()=>(quantidade * produto.preco);
  
  String toString() => "Produto: $produto\nQuantidade: $quantidade\nTotal: ${totalItem()}\n\n";
  
}


class Venda{
  final DateTime data;
  List<Item> itens = [];
  
    
  double total() => itens.fold(0, (sum,e) => sum + e.totalItem());
  
  void addItem(Item item){
    itens.add(item);
  }
  
  Venda({required this.data});
  
  String toString() => "Data: $data\nItens: $itens\nValor da venda: ${total()}";
  
}



void main() {
  Produto pao = Produto(nome:"Pão", preco: 5);
  Produto queijo = Produto(nome:"Queijo", preco: 8);
  Produto farinha = Produto(nome:"Farinha", preco: 12);
  
  Item pacotes = Item(produto: pao, quantidade: 3);
  Item embalagens = Item(produto: queijo, quantidade: 5);
  Item sacos = Item(produto: farinha, quantidade: 8);
  
  
  Venda venda = Venda(data: DateTime.now());
  venda.addItem(pacotes);
  venda.addItem(embalagens);
  venda.addItem(sacos);
  print(venda);
  
}
