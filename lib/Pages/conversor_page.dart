import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var request = Uri.parse('https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL');

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

Future<Map<String, dynamic>> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class _ConversorPageState extends State<ConversorPage> {
  double? dollar;
  double? euro;

  final TextEditingController euroController = TextEditingController();
  final TextEditingController dollarController = TextEditingController();
  final TextEditingController realController = TextEditingController();

  void _realChanged(String text) {
    double real = double.parse(text);
    dollarController.text = (real / dollar!).toStringAsFixed(2);
    euroController.text = (real / euro!).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    double valDolar = double.parse(text);
    realController.text = (valDolar * dollar!).toStringAsFixed(2);
    euroController.text = ((valDolar * dollar!) / euro!).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double valEuro = double.parse(text);
    realController.text = (valEuro * euro!).toStringAsFixed(2);
    dollarController.text = ((valEuro * euro!) / dollar!).toStringAsFixed(2);
  }

  Widget buildTextFromField(String label, String prefix,
      TextEditingController controller, Function(String text) f) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      style: TextStyle(color: Colors.amber, fontSize: 25),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixStyle: TextStyle(color: Colors.amber, fontSize: 25),
        prefixText: prefix,
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.amber,
          fontSize: 25,
        ),
      ),
      onChanged: f,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              dollarController.clear();
              realController.clear();
              euroController.clear();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'Conversor de Moedas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "ERRO ao Carregar Dados :(",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dollar = double.parse(snapshot.data!["USDBRL"]["ask"]);
                euro = double.parse(snapshot.data!["EURBRL"]["ask"]);
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.amber,
                        size: 200,
                      ),
                      buildTextFromField(
                          'Reais', 'R\$', realController, _realChanged),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextFromField(
                          'Euros', '€', euroController, _euroChanged),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextFromField(
                          'Dólares', '\$', dollarController, _dollarChanged)
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
