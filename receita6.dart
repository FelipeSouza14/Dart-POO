import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);

  void carregar(index) {
    final carregamento = [carregarCafes, carregarCervejas, carregarNacoes];
    carregamento[index]();
  }

  void carregarCervejas() {
    tableStateNotifier.value = [
      {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
      {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
      {"name": "Duvel", "style": "Pilsner", "ibu": "82"}
    ];
  }

  void carregarCafes() {
    tableStateNotifier.value = [
      {
        "name": "Antigua Guatemalan coffee",
        "intensifier": "Intense flavor",
        "origin": "Antigua, Guatemala"
      },
      {
        "name": "Costa Rican Coffee Tarrazú",
        "intensifier": "Soft",
        "origin": "Tarrazú, Costa Rica"
      },
      {
        "name": "Chiapas Mexican Coffee",
        "intensifier": "Balanced acidity",
        "origin": "Chiapas, Mexico"
      }
    ];
  }

  void carregarNacoes() {
    tableStateNotifier.value = [
      {"name": "Brazil", "language": "Portuguese", "capital": "Brasília"},
      {"name": "Canada", "language": "English and French", "capital": "Ottawa"},
      {"name": "Germany", "language": "German", "capital": "Berlim"}
    ];
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

  static const List<Map<String, dynamic>> objectsBar = [
    {
      "label": "Cafés",
      "icon": Icon(Icons.coffee_outlined),
      "columnNames": ["Nome", "Origem", "Intensidade"],
      "propertyNames": ["name", "origin", "intensifier"],
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
      "columnNames": ["Nome", "Linguagem", "Capital"],
      "propertyNames": ["name", "language", "capital"],
    },
  ];

  @override
  void initState() {
    super.initState();
    dataService.carregar(sIndex);
  }

  void tappedItem(int index) {
    setState(() {
      sIndex = index;
      dataService.carregar(sIndex);
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
              title: const Text("Dicas"),
            ),
            body: ValueListenableBuilder(
                valueListenable: dataService.tableStateNotifier,
                builder: (context, value, child) {
                  return DataTableWidget(
                    jsonObjects: value,
                    columnNames: objectsNavBar["columnNames"],
                    propertyNames: objectsNavBar["propertyNames"]
                  );
                }),
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
            )
      )
    );
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
        ]
    );
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
    return DataTable(
        columns: columnNames.map(
          (name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic))
                      )
                    )
                  ).toList(),
        rows: jsonObjects.map((obj) => DataRow(
                cells: propertyNames.map((propName) => DataCell(Text(obj[propName] ?? ""))
        ).toList()
      )
    ).toList());
  }
}
