import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

void interface1() {

  MaterialApp app = MaterialApp(

      theme: ThemeData(primarySwatch: Colors.green),

      home: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text("Vegan"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.eco),
            )],
          leading:
            IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed: () {
              },
            )
          
                      ),

        body: 
        
  
  Center(child: Column(
    children: [
      
      FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: 'https://uploads.metropoles.com/wp-content/uploads/2021/07/05105850/1bolo-banana-caramelizada.jpeg', width: 400),
      
      
      Text('Recomendações da Casa:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text('1 - Bolo de Banana', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
      Text('2 - Ratatouille', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
      Text('3 - Bolinho de Arroz', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
      Text('4 - Salada de Frutas', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
      Text('5 - Guacamole', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic))
    
    ])),

              
  

        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [ElevatedButton(
          child: Icon(Icons.add),
          onPressed: (){
            print('Pedido Feito');
          }
          ),
         ElevatedButton(
          child: Icon(Icons.chrome_reader_mode_outlined),
          onPressed: (){
            print('Cardápio');
          }
          ),
          ElevatedButton(
          child: Icon(Icons.delivery_dining),
          onPressed: (){
            print('Entrega');
          }
          )
                     
                     
        ]),

      ));

  runApp(app);

}
