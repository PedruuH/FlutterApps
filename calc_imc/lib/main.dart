import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
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
          backgroundColor: Colors.green,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: null)
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Icon(Icons.person, size: 120.0, color: Colors.green),
        TextField(keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Peso (Kg)",
                labelStyle: TextStyle(color: Colors.green)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0)),
        TextField(keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: "Altura (cm)",
              labelStyle: TextStyle(color: Colors.green)),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25.0)),

          ],
        )
    )
  }
}
