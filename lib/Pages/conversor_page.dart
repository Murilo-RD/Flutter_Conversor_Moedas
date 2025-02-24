import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var request =
    Uri.parse('https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL');

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  double? dollar;
  double? euro;

  final TextEditingController euroController = TextEditingController();
  final TextEditingController dollarController = TextEditingController();
  final TextEditingController realController = TextEditingController();

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  Widget buildTextFromField(String label,String prefix,TextEditingController controller){
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      onFieldSubmitted: (String value){
        setState(() {
          try {
            double aux = 0;
            if(label == 'Dólares'){
              aux = double.parse(value!);
              realController.text = (aux*dollar!).toString();
              euroController.text = ((aux*dollar!)/euro!).toString();
            }else if(label == 'Euros'){
              aux = double.parse(value!);
              realController.text = (aux*euro!).toString();
              dollarController.text = ((aux*euro!)/dollar!).toString();
            }else{
              aux = double.parse(value!);
              dollarController.text = (aux/dollar!).toString();
              euroController.text = (aux/euro!).toString();

            }
          } on Exception catch (e) {
            print ('ok');
          }
        });

      } ,
      style: TextStyle(color: Colors.amber,fontSize: 25),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixStyle: TextStyle(color: Colors.amber,fontSize: 25),
        prefixText: prefix ,
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.amber,
          fontSize: 25,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
   // getData();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.amber,
                        size: 200,
                      ),
                      buildTextFromField('Reais', 'R\$',realController),
                      SizedBox(height: 20,),
                      buildTextFromField('Euros', '€',euroController),
                      SizedBox(height: 20,),
                      buildTextFromField('Dólares', '\$',dollarController)
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


