import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  List<Icon> icons;
  IconBox({this.icons = const []});

  void botao(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: botao,
      items: icons.map((e) => BottomNavigationBarItem(icon: e,label: 'Icone')
    ).toList());
  }
}

class ModifiedAppBar extends StatelessWidget implements PreferredSizeWidget {
  ModifiedAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true, title: Text("Programinha"));
  }
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        home: Scaffold(
          appBar: ModifiedAppBar(),
          body: BuildBody(),
          bottomNavigationBar: IconBox(icons: [Icon(Icons.coffee_outlined), Icon(Icons.access_alarm), Icon(Icons.house_outlined)],),
        ));
  }
}

class BuildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Column(children: [
      Expanded(
        child: Text("La Fin Du Monde - Bock - 65 ibu"),
      ),
      Expanded(
        child: Text("Sapporo Premiume - Sour Ale - 54 ibu"),
      ),
      Expanded(
        child: Text("Duvel - Pilsner - 82 ibu"),
      ),
    ]));
  }
}

void main() {
  MyApp app = MyApp();

  runApp(app);
}
