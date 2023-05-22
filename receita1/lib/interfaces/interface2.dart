import 'package:flutter/material.dart';

void interface2() {

  MaterialApp app = MaterialApp(

      theme: ThemeData(primarySwatch: Colors.green),

      home: Scaffold(

        appBar: AppBar(
          title: Text("Cervejas"),
          
     ),


        body: 
        Center(
          child: ListView(
            children: [

          DataTable(
            columns: [
            DataColumn(
            label: Expanded(
                  child: Text(
                    'Nome',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),

              DataColumn(
            label: Expanded(
                  child: Text(
                    'Estilo',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),

              DataColumn(
            label: Expanded(
                  child: Text(
                    'IBU',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              )
            ],

            rows: [
              DataRow(cells: [
                DataCell(Text('La Fin Du Monde')),
                DataCell(Text('Bock')),
                DataCell(Text('65'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Sapporo Premium')),
                DataCell(Text('Sour Ale')),
                DataCell(Text('54'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Duvel')),
                DataCell(Text('Pilsner')),
                DataCell(Text('82'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Antarctica')),
                DataCell(Text('Saison')),
                DataCell(Text('62'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Bohemia')),
                DataCell(Text('Stout')),
                DataCell(Text('85'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Brahma')),
                DataCell(Text('Gose')),
                DataCell(Text('54'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Caracu')),
                DataCell(Text('Berliner Weisse')),
                DataCell(Text('88'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Skol')),
                DataCell(Text('Scotch Ale')),
                DataCell(Text('42'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Serrana')),
                DataCell(Text('Rauchbier')),
                DataCell(Text('64'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Polar')),
                DataCell(Text('Lager')),
                DataCell(Text('55'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Budweiser')),
                DataCell(Text('Amber Ale')),
                DataCell(Text('68'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Devassa')),
                DataCell(Text('Witbier')),
                DataCell(Text('58'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Heineken')),
                DataCell(Text('Kölsch')),
                DataCell(Text('56'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Itaipava')),
                DataCell(Text('Dunkelweizen')),
                DataCell(Text('45'))
              ] ),

              DataRow(cells: [
                DataCell(Text('Kaiser')),
                DataCell(Text('American Wheat Ale')),
                DataCell(Text('52'))
              ] ),
            ]
          ),
        ]
      )
    )
  )
);

runApp(app);

}
