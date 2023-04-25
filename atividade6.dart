import 'package:flutter/material.dart';

var dataObjects = [
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "Stella Artois", "style": "Pilsner", "ibu": "18"},
  {"name": "Corona", "style": "Mexican Lager", "ibu": "58"},
  {"name": "Guinness", "style": "Irish Dry Stout", "ibu": "82"},
  {"name": "Budweiser", "style": "American Lager", "ibu": "15"},
  {"name": "Blue Moon", "style": "Belgian White Ale", "ibu": "44"},
  {"name": "Hoegaarden", "style": "Belgian Witbier", "ibu": "48"},
  {"name": "Paulaner", "style": "Hefeweizen", "ibu": "56"},
  {"name": "Warsteiner", "style": "German Pilsner", "ibu": "75"},
  {"name": "Franziskaner", "style": "Hefeweizen", "ibu": "85"},
  {"name": "Amstel", "style": "Lager", "ibu": "88"},
  {"name": "Beck's", "style": "Pilsner", "ibu": "72"},
  {"name": "Carlsberg", "style": "Pilsner", "ibu": "56"},
  {"name": "Leffe", "style": "Belgian Blonde Ale", "ibu": "77"},
  {"name": "Dos Equis", "style": "Mexican Lager", "ibu": "61"},
  {"name": "La Chouffe", "style": "Belgian Strong Ale", "ibu": "63"},
  {"name": "Modelo", "style": "Mexican Lager", "ibu": "55"},
  {"name": "Chimay", "style": "Belgian Dubbel", "ibu": "58"}
];

class DataBodyWidget extends StatelessWidget {
  List<Map<String,dynamic>> objects;
  List<String> columnNames;
  List<String> propertyNames;


  DataBodyWidget({this.objects = const [], this.columnNames = const [], this.propertyNames = const []});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: objects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
  }
}

class NewNavBar extends StatelessWidget {
  NewNavBar();

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [
      BottomNavigationBarItem(
        label: "Cafés",
        icon: Icon(Icons.coffee_outlined),
      ),
      BottomNavigationBarItem(
          label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
      BottomNavigationBarItem(label: "Nações", icon: Icon(Icons.flag_outlined))
    ]);
  }
}

class MyTileWidget extends StatelessWidget {
  List<Map<String, dynamic>> objects;
  final List<String> columnName;
  final List<String> propertyName;

  MyTileWidget(
      {this.objects = const [],
      this.columnName = const [],
      this.propertyName = const []});

  @override
  Widget build(BuildContext context) {
    var columnNames = ["Nome", "Estilo", "IBU"],
        propertyNames = ["name", "style", "ibu"];

    return ListView.builder(
        itemCount: objects.length,
        itemBuilder: (context, index) {
          final objeto = objects[index];
          final namesColumn = columnNames.map((col) {
            final propert = propertyNames[columnNames.indexOf(col)];
            return Text("$col: ${objeto[propert]}");
          }).toList();

          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: namesColumn,
          ),
        );
      }
    );
  }
}

// ------------------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Bebidas da Casa"),
          ),
          body: ListView(
                  children: [
                    DataBodyWidget(
                    objects: dataObjects, 
                    columnNames: ["Nome", "Estilo", "IBU"], 
                    propertyNames: ["name", "style", "ibu"]
                  )
                ]
              ),                
          bottomNavigationBar: NewNavBar(),
        ));
  }
}

void main() {
  MyApp app = MyApp();
  runApp(app);
}
