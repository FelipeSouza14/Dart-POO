import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

enum ItemType { beer, coffee, nation, none }

class DataService {
  static const MAX_N_ITEMS = 15;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 7;

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n) {
    _numberOfItems = n < 0
        ? MIN_N_ITEMS
        : n > MAX_N_ITEMS
            ? MAX_N_ITEMS
            : n;
  }

  int get numberOfItems {
    return _numberOfItems;
  }

  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none
  });

  void carregar(index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];

    bool coffeeIconSelected = false;
    bool nationIconSelected = false;
    bool beerIconSelected = false;

    if (index == 0) {
      coffeeIconSelected = true;
    } 
    else if (index == 1) {
      beerIconSelected = true;
    } 
    else if (index == 2) {
      nationIconSelected = true;
    }

    funcoes[index]();
  }

  void carregarFuncoes(ItemType itemType, String itemPath,
      List<String> propertyNames, List<String> columnNames) {
    //ignorar solicitação se uma requisição já estiver em curso
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;
    if (tableStateNotifier.value['itemType'] != itemType) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': itemType
      };
    }

    var funcoesUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: itemPath,
        queryParameters: {'size': '$_numberOfItems'});

    http.read(funcoesUri).then((jsonString) {
      var funcoesJson = jsonDecode(jsonString);

      //se já houver nações no estado da tabela...

      if (tableStateNotifier.value['status'] != TableStatus.loading)
        funcoesJson = [
          ...tableStateNotifier.value['dataObjects'],
          ...funcoesJson
        ];

      tableStateNotifier.value = {
        'itemType': itemType,
        'status': TableStatus.ready,
        'dataObjects': funcoesJson,
        'propertyNames': propertyNames,
        'columnNames': columnNames
      };
    });
  }

  void carregarCafes() {
    carregarFuncoes(
      ItemType.coffee, 
      'api/coffee/random_coffee',
      ["blend_name", "origin", "variety"], 
      ["Nome", "Origem", "Tipo"]);
  }

  void carregarNacoes() {
    carregarFuncoes(
        ItemType.nation,
        'api/nation/random_nation',
        ["nationality", "capital", "language", "national_sport"],
        ["Nome", "Capital", "Idioma", "Esporte"]);
  }

  void carregarCervejas() {
    carregarFuncoes(
      ItemType.beer, 
      'api/beer/random_beer',
      ["name", "style", "ibu"], 
      ["Nome", "Estilo", "IBU"]);
  }
}

final dataService = DataService();
