import 'package:flutter/material.dart';

class ModifiedAppBar extends StatelessWidget implements PreferredSizeWidget {
  ModifiedAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Curso de Inglês - Matrícula"),
    );
  }
}

class BuildBody extends StatelessWidget {
  int valor = 0;
  int valor_dois = 0;
  int animar = 50;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      // TODO: implement build
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            Row(children: [
              Text(
                "Qual a sua idade?",
                style: TextStyle(fontSize: 20),
              )
            ]),
            Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: valor,
                    onChanged: (value) {
                      setState(() {
                        valor = value!;
                      });
                    }),
                Text("Entre 12 e 17 anos")
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 2,
                    groupValue: valor,
                    onChanged: (value) {
                      setState(() {
                        valor = value!;
                      });
                    }),
                Text("Mais de 18 anos")
              ],
            ),
            Row(children: [
              Text(
                "Qual o seu nível de inglês?",
                style: TextStyle(fontSize: 20),
              )
            ]),
            Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: valor_dois,
                    onChanged: (value) {
                      setState(() {
                        valor_dois = value!;
                      });
                    }),
                Text("Iniciante")
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 2,
                    groupValue: valor_dois,
                    onChanged: (value) {
                      setState(() {
                        valor_dois = value!;
                      });
                    }),
                Text("Intermediário")
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 3,
                    groupValue: valor_dois,
                    onChanged: (value) {
                      setState(() {
                        valor_dois = value!;
                      });
                    }),
                Text("Avançado")
              ],
            ),
            Text(
              "O quão animado você está para começar?",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [Text(animar.toString()), Text("Animação")],
            ),
            Slider(
                value: animar.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    animar = value.round();
                  });
                }),
            ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Formulário sendo processado'),
                    duration: Duration(seconds: 3),
                  ));
                },
                  child: Text('Enviar')
              )
            ]
          )
        );
      }
    );
  }
}

// ------------------------------------------------------------------------------------------------------------

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
      ),
    );
  }
}

void main() {
  MyApp app = MyApp();

  runApp(app);
}
