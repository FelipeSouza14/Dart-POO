import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);

  Future<void> carregar(int index, int? menuCount) async {
    final carregamento = [carregarCafes, carregarCervejas, carregarNacoes];
    await carregamento[index](menuCount);
  }

  Future<void> carregarCervejas(int? menuCount) async {
    var beersUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/beer/random_beer',
        queryParameters: {'size': '$menuCount'});

    var jsonString = await http.read(beersUri);
    var beersJson = jsonDecode(jsonString);

    tableStateNotifier.value = List.from(beersJson);
  }

  Future<void> carregarCafes(int? menuCount) async {
    var coffeesUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com/',
        path: 'api/coffee/random_coffee',
        queryParameters: {'size': '$menuCount'});

    var jsonString = await http.read(coffeesUri);
    var coffeesJson = jsonDecode(jsonString);

    tableStateNotifier.value = List.from(coffeesJson);
  }

  Future<void> carregarNacoes(int? menuCount) async {
    var nationsUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/nation/random_nation',
        queryParameters: {'size': '$menuCount'});

    var jsonString = await http.read(nationsUri);
    var nationsJson = jsonDecode(jsonString);

    tableStateNotifier.value = List.from(nationsJson);
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
      "icon": Icon(Icons.coffee_outlined),
      "columnNames": ["Nome", "Origem", "Intensidade"],
      "propertyNames": ["blend_name", "origin", "intensifier"],
    },
    {
      "label": "Cervejas",
      "icon": Icon(Icons.local_drink_outlined),
      "columnNames": ["Nome", "Estilo", "IBU"],
      "propertyNames": ["name", "style", "ibu"],
    },
    {
      "label": "Nações",
      "icon": Icon(Icons.flag_outlined),
      "columnNames": ["Nacionalidade", "Linguagem", "Capital"],
      "propertyNames": ["nationality", "language", "capital"],
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
              title: Text("Programinha"),
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
                      return DataTableWidget(
                          jsonObjects: value,
                          columnNames: objectsNavBar["columnNames"],
                          propertyNames: objectsNavBar["propertyNames"]);
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
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined))
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
    return ListView(
        children: [
          DataTable(
            columns: 
            columnNames.map((name) => DataColumn(
                  label: Expanded(
                  child: Text(name,
                  style: TextStyle(fontStyle: FontStyle.italic)
                  )
                )
              )
            ).toList(),
            rows: 
            jsonObjects.map((obj) => DataRow(
                  cells: 
                  propertyNames.map((propName) => DataCell(Text(obj[propName] ?? ""))).toList()
                  )
                ).toList()
        )
      ]
    );
  }
}
