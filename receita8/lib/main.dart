import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({'status': TableStatus.idle, 'dataObjects': []});

  void carregar(int index, int? menuCount) {
    final carregamento = [carregarCafes, carregarCervejas, carregarNacoes, carregarComidas];
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': []
    };
    carregamento[index](menuCount);
  }

  void carregarCervejas(int? menuCount) {
    var beersUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/beer/random_beer',
        queryParameters: {'size': '$menuCount'});

    http.read(beersUri).then((jsonString) {
      var beersJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'columnNames': ["Nome", "Estilo", "IBU"],
        'propertyNames': ["name", "style", "ibu"]
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    });
  }

  void carregarCafes(int? menuCount) {
    var coffeesUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/coffee/random_coffee',
        queryParameters: {'size': '$menuCount'});

    http.read(coffeesUri).then((jsonString) {
      var coffeesJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': coffeesJson,
        'columnNames': ["Nome", "Origem", "Intensidade"],
        'propertyNames': ["blend_name", "origin", "intensifier"],
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    });
  }

  void carregarComidas(int? menuCount) {
    var foodsUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/food/random_food',
        queryParameters: {'size': '$menuCount'});

    http.read(foodsUri).then((jsonString) {
      var foodsJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': foodsJson,
        'columnNames': ["Prato", "Descrição", "Ingredientes"],
        'propertyNames': ["dish", "description", "ingredient"],
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    });
  }

  Future<void> carregarNacoes(int? menuCount) async {
    var nationsUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/nation/random_nation',
        queryParameters: {'size': '$menuCount'});

    var jsonString = await http.read(nationsUri);
    var nationsJson = jsonDecode(jsonString);

    tableStateNotifier.value = {
      'status': TableStatus.ready,
      'dataObjects': nationsJson,
      'columnNames': ["Nacionalidade", "Linguagem", "Capital"],
      'propertyNames': ["nationality", "language", "capital"],
    };
  }
  catchError(error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    }
}

final dataService = DataService();

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatefulWidget {
  @override
  StateMyApp createState() => StateMyApp();
}

class StateMyApp extends State<MyApp> {
  int sIndex = 0;
  int? menuCount = 5;
  bool table = false;

  static const List<Map<String, dynamic>> objectsBar = [
    {
      "label": "Cafés",
      "icon": Icon(Icons.coffee_outlined, color: Colors.deepPurple),
    },
    {
      "label": "Cervejas",
      "icon": Icon(Icons.local_drink_outlined, color: Colors.deepPurple),
    },
    {
      "label": "Nações",
      "icon": Icon(Icons.flag_outlined, color: Colors.deepPurple),
    },
    {
      "label": "Comidas",
      "icon": Icon(Icons.dinner_dining_outlined, color: Colors.deepPurple),
    },
  ];

  @override
  void initState() {
    super.initState();
    dataService.carregar(sIndex, menuCount);
  }

  void tappedItem(int index) {
    setState(() {
      sIndex = index;
      table = true;
      dataService.carregar(sIndex, menuCount);
    });
  }

  void menuItemSelected(int? value) {
    setState(() {
      menuCount = value;
      dataService.carregar(sIndex, menuCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final objectsNavBar = objectsBar[sIndex];

    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Dicas"),
              actions: [
                DropdownButton<int>(
                  value: menuCount,
                  items: [
                    DropdownMenuItem<int>(value: 5, child: Text("5")),
                    DropdownMenuItem<int>(value: 10, child: Text("10")),
                    DropdownMenuItem<int>(value: 15, child: Text("15"))
                  ],
                  onChanged: menuItemSelected,
                )
              ],
            ),
            body: Visibility(
                visible: table,
                child: ValueListenableBuilder(
                    valueListenable: dataService.tableStateNotifier,
                    builder: (context, value, child) {

                      switch (value['status']) {
                        case TableStatus.idle:
                          return Center(child: Column(
                            children: [
                              FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: 'https://www.google.com.br/url?sa=i&url=https%3A%2F%2Fgartic.com.br%2Flyn999%2Fdesenho-livre%2Fseja-bem-vindo-ao-meu-mural-5&psig=AOvVaw0V5AxLbMHF-hNdd2OenbMA&ust=1685239669914000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCMDBrY21lP8CFQAAAAAdAAAAABAE'),

                              Text("Interaja tocando em um dos botões!")
                             ])
                             );

                        case TableStatus.loading:
                          return Center(child: CircularProgressIndicator());

                        case TableStatus.ready:
                          return DataTableWidget(
                              jsonObjects: value['dataObjects'],
                              columnNames: value['columnNames'],
                              propertyNames: value['propertyNames']);
                        case TableStatus.error:
                          return Text("Deu erro! Salve-se! Verifique a sua conexão com a internet");
                      }

                      return Text("...");
                    })),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                for (var item in objectsBar)
                  BottomNavigationBarItem(
                    label: item["label"],
                    icon: item["icon"],
                  ),
              ],
              currentIndex: sIndex,
              onTap: tappedItem,
            )));
  }
}

class NewNavBar extends HookWidget {
  final void Function(int)? itemSelectedCallback;
  NewNavBar({this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    var state = useState(1);
    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          itemSelectedCallback?.call(index);
          //carregarCervejas();
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined, color: Colors.deepPurple),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined, color: Colors.deepPurple)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined, color: Colors.deepPurple)),
          BottomNavigationBarItem(
              label: "Comidas", icon: Icon(Icons.dinner_dining_outlined, color: Colors.deepPurple))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({
    this.jsonObjects = const [],
    this.columnNames = const [],
    this.propertyNames = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      DataTable(
          columns: columnNames
              .map((name) => DataColumn(
                  label: Expanded(
                      child: Text(name,
                          style: TextStyle(fontStyle: FontStyle.italic)))))
              .toList(),
          rows: jsonObjects
              .map((obj) => DataRow(
                  cells: propertyNames
                      .map((propName) => DataCell(Text(obj[propName] ?? "")))
                      .toList()))
              .toList())
    ]);
  }
}
