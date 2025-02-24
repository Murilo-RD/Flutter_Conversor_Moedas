import 'package:conversor_moedas/Pages/conversor_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
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

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversorPage();
  }
}
