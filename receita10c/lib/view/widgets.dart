import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../data/data_service.dart';


class MenuOptions {
  static const menuOptions = [3, 15, 7];
}

class MyApp extends StatelessWidget {
  final loadMenuOptions = MenuOptions.menuOptions;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
            actions: [
              PopupMenuButton(
                itemBuilder: (_) => loadMenuOptions
                    .map((num) => PopupMenuItem(
                        value: num, child: Text("Carregar $num itens por vez")))
                    .toList(),
                onSelected: (number) {
                  dataService.numberOfItems = number;
                },
              )
            ],
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                switch (value['status']) {
                  case TableStatus.idle:
                    return Center(child: Text("Toque em algum botão"));

                  case TableStatus.loading:
                    return Center(child: CircularProgressIndicator());

                  case TableStatus.ready:
                    return SingleChildScrollView(
                        child: DataTableWidget(
                            jsonObjects: value['dataObjects'],
                            propertyNames: value['propertyNames'],
                            columnNames: value['columnNames']));

                  case TableStatus.error:
                    return Text("Lascou");
                }
                return Text("...");
              }),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class NewNavBar extends HookWidget {
  final _itemSelectedCallback;

  NewNavBar({itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback ?? (int) {}

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          _itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Endereços",
            icon: Icon(Icons.add_location_alt_outlined),
          ),
          BottomNavigationBarItem(
              label: "Comidas", icon: Icon(Icons.dining_outlined)),
          BottomNavigationBarItem(
              label: "Dispositivos", icon: Icon(Icons.android_outlined))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget(
      {this.jsonObjects = const [],
      this.columnNames = const [],
      this.propertyNames = const []});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columns: columnNames
                .map((name) => DataColumn(
                  onSort: (columnIndex, ascending)=> dataService.ordenarEstadoAtual(propertyNames[columnIndex]),
                    label: Expanded(
                        child: Text(name,
                            style: TextStyle(fontStyle: FontStyle.italic)))))
                .toList(),
            rows: jsonObjects
                .map((obj) => DataRow(
                    cells: propertyNames
                        .map((propName) => DataCell(Text(obj[propName])))
                        .toList()))
                .toList()));
  }
}
