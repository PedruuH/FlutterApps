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
  late double dolares;
  late double euros;

  TextEditingController reaisController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  void _realChanged(String text){
    double real = double.parse(text);
    euroController.text = (real/euros).toStringAsPrecision(4);
    dolarController.text = (real/dolares).toStringAsPrecision(4);
  }
  void _euroChanged(String text){
    double euro = double.parse(text);
    reaisController.text = (euro* euros).toStringAsPrecision(4);
    dolarController.text = (euro*euros/dolares).toStringAsPrecision(4);
  }
  void _dolarChanged(String text){
    double dolar = double.parse(text);
    euroController.text = (dolar*dolares/euros).toStringAsPrecision(4);
    reaisController.text = (dolar*dolares).toStringAsPrecision(4);
  }
  void _resetFields()
  {
    euroController.text = "";
    dolarController.text = "";
    reaisController.text = "";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: const Text("Conversor Moeda"),
            centerTitle: true,
            backgroundColor: Colors.amber,
            actions: [IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))]),
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
                    dolares = snapshot.requireData["results"]["currencies"]["USD"]
                        ["buy"];
                    euros = snapshot.requireData["results"]["currencies"]["EUR"]
                        ["buy"];

                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Icon(Icons.monetization_on_outlined,
                                size: 150.0, color: Colors.amber),
                            buildTextField("Reais", "R\$", reaisController, _realChanged),
                            Divider(),
                            buildTextField("Dólar", "US\$", dolarController, _dolarChanged),
                            Divider(),
                            buildTextField("Euro", "€", euroController, _euroChanged)
                          ],
                        ));
                  }
              }
            }));
  }
}

Widget buildTextField(String label, String prefix, TextEditingController c, Function fun)
{return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix,
        prefixStyle: TextStyle(
            color: Colors.amber, fontSize: 25.0),
      ),
      style: TextStyle(
          color: Colors.amber, fontSize: 25.0),
        controller: c,
        onChanged: (String value){ fun(value);}
    );}
