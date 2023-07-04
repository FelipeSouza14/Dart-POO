abstract class Decididor {
  bool precisaTrocarAtualPeloProximo(dynamic atual, dynamic proximo);
}

class Ordenador{

  List ordenarItensDeModoCrescente(List itens, String propriedade){
    List itensOrdenados = List.of(itens);
    bool trocouAoMenosUm;

    do{
      trocouAoMenosUm = false;

      for (int i=0; i<itensOrdenados.length-1; i++){
        var atual = itensOrdenados[i];
        var proximo = itensOrdenados[i+1];

        if (atual[propriedade].compareTo(proximo[propriedade]) > 0){
          var aux = itensOrdenados[i];
          itensOrdenados[i] = itensOrdenados[i+1];
          itensOrdenados[i+1] = aux;
          trocouAoMenosUm = true;
        }
      }

    }while(trocouAoMenosUm);

    return itensOrdenados;

  }
}