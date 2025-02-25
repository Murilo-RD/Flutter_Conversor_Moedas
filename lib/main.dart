import 'package:conversor_moedas/Pages/conversor_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.amber,
        primaryColor:Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        )
      ),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ConversorPage();
  }
}

