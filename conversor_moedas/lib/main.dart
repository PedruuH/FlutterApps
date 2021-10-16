import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance/quotations?format=json&key=a91b936b";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double dolar;
  late double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Conversor Moeda"),
          centerTitle: true,
          backgroundColor: Colors.amber,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                      child: Text("Carregando...",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                          textAlign: TextAlign.center));
                default:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Erro ao carregar dados :(",
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                            textAlign: TextAlign.center));
                  } else {
                    dolar = snapshot.requireData["results"]["currencies"]["USD"]
                        ["buy"];
                    euro = snapshot.requireData["results"]["currencies"]["EUR"]
                        ["buy"];
                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(Icons.monetization_on_outlined,
                                size: 150.0, color: Colors.amber),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Reais",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "R\$",
                                prefixStyle: TextStyle(
                                    color: Colors.amber, fontSize: 25.0),
                              ),
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 25.0),
                            ),
                            Divider(),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Dolar",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "US\$",
                                prefixStyle: TextStyle(
                                    color: Colors.amber, fontSize: 25.0),
                              ),
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 25.0),
                            ),
                            const Divider(),
                            TextField(
                                keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Euro",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "€",
                                prefixStyle: TextStyle(
                                    color: Colors.amber, fontSize: 25.0),
                              ),
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 25.0),
                            ),
                          ],
                        ));
                  }
              }
            }));
  }
}
