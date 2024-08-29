import 'package:flutter/material.dart';
import 'package:learningdart/pages/calculator_page.dart';
import 'package:learningdart/pages/counter_page.dart';
import 'package:learningdart/pages/home_page.dart';
//STATELESS Widgets are widgets that won't ever change, whereas STATEFUL Widgets change depending on the state
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: const HomePage(),
      routes: {
        "/homepage": (context)=> const HomePage(),
        "/calculatorpage": (context)=>CalculatorPage(),
        "/counterpage":(context)=>CounterPage(),    
        }
    );
  }
}
