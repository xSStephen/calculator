import 'package:calculator/pages/basic_calculator.dart';
import 'package:calculator/pages/other_tools.dart';
import 'package:calculator/pages/tools/currency_calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BasicCalculator(),
      routes: {
        '/tools/currency_calculator': (context) => const CurrencyCalculator(),
        '/other_tools': (context) => const OtherTools(),
      },
    );
  }
}
