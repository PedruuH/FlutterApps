import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home()
  ));
      
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.person, size: 120.0),
          const TextField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Peso em Kg",
            labelStyle: TextStyle(color: Colors.black)
          ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          const TextField(keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Altura em cm",
                labelStyle: TextStyle(color: Colors.black,fontSize: 19.0)
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          )
        ]
      )
    );
  }
}
