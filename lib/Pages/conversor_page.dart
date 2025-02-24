import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

var request =
    Uri.parse('https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL');

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  @override
  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff383521),
        centerTitle: true,
        title: Text(
          'Conversor de Moedas',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25),
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
              break;
          }
        },
      ),
    );
  }
}
