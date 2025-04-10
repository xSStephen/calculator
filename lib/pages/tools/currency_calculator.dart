import 'package:calculator/modules/page_template.dart';
import 'package:flutter/material.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({super.key});

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Currency Calculator',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
