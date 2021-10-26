import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String _infoText = "Informe seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 39.9) {
        _infoText = "Obesidade III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.person, size: 120.0),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Peso em Kg",
                            labelStyle: TextStyle(color: Colors.black)),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 20.0),
                        controller: pesoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira um peso";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Altura em cm",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 19.0)),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 20.0),
                        controller: alturaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira uma altura";
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          //descolar botão do TextField
                          child: Container(
                              height: 45.0,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _calcular();
                                    }
                                  },
                                  child: const Text(
                                    'Calcular',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue)))),
                      Text(_infoText,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 25.0))
                    ]))));
  }
}
