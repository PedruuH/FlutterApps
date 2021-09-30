import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
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
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.person, size: 120.0),
          TextField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Peso em Kg",
            labelStyle: TextStyle(color: Colors.white)
          ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          )
        ]
      )
    );
  }
}
