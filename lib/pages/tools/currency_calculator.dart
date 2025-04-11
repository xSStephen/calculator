import 'package:calculator/modules/calculator_buttons.dart';
import 'package:calculator/modules/page_template.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({super.key});

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  // User data
  String userQuestion = '';
  String userAnswer = '';

  // A list of buttons to be displayed on the calculator
  final List<String> buttons = [
    'C',
    'icon_del',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '',
    '0',
    '.',
    '=',
  ];

  // List of currencies with full names and short names
  final List<Map<String, String>> currencies = [
    {'name': 'United States Dollar', 'short': 'USD'},
    {'name': 'Euro', 'short': 'EUR'},
    {'name': 'British Pound', 'short': 'GBP'},
    {'name': 'Japanese Yen', 'short': 'JPY'},
    {'name': 'Australian Dollar', 'short': 'AUD'},
    {'name': 'Canadian Dollar', 'short': 'CAD'},
  ];

  // Selected currencies
  String selectedCurrency1 = 'USD';
  String selectedCurrency2 = 'EUR';

  Map<String, double> exchangeRates = {};

  @override
  void initState() {
    super.initState();
    print('initState called'); // Debug print
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    const String apiKey =
        'ed704da1f87eefccd9f741cb'; // Replace with your API key
    const String apiUrl =
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/USD';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('API Response: $data'); // Debug print to log the API response

        setState(() {
          // Convert all values in conversion_rates to double
          exchangeRates = (data['conversion_rates'] as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, value.toDouble()));
          print(
              'Exchange Rates Map: $exchangeRates'); // Debug print to log the map
        });
      } else {
        print('Failed to fetch exchange rates: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching exchange rates: $e');
    }
  }

  double convertCurrency(String from, String to, double amount) {
    if (exchangeRates.isEmpty ||
        !exchangeRates.containsKey(from) ||
        !exchangeRates.containsKey(to)) {
      return 0.0;
    }
    double fromRate = exchangeRates[from]!;
    double toRate = exchangeRates[to]!;
    return (amount / fromRate) * toRate;
  }

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
        body: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              // First row
              SizedBox(
                height: 100, // Set a fixed height for the first row
                child: Row(
                  children: [
                    // First row, first column: Dropdown for selecting currencies
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                          value: selectedCurrency1,
                          dropdownColor: Colors.grey,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          style: const TextStyle(color: Colors.white),
                          items: currencies.map((currency) {
                            return DropdownMenuItem<String>(
                              value: currency[
                                  'short'], // Use the 'short' value as the key
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      currency[
                                          'name']!, // Full name of the currency
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    currency[
                                        'short']!, // Short name of the currency
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCurrency1 =
                                  newValue!; // Update the selected currency
                            });
                          },
                        ),
                      ),
                    ),
                    // First row, second column: User input
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: Text(
                          userQuestion,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Second row
              SizedBox(
                height: 100, // Set a fixed height for the second row
                child: Row(
                  children: [
                    // Second row, first column: Dropdown for selecting currencies
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                          value: selectedCurrency2,
                          dropdownColor: Colors.grey,
                          style: const TextStyle(color: Colors.white),
                          items: currencies.map((currency) {
                            return DropdownMenuItem<String>(
                              value: currency[
                                  'short'], // Use the 'short' value as the key
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      currency[
                                          'name']!, // Full name of the currency
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    currency[
                                        'short']!, // Short name of the currency
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCurrency2 =
                                  newValue!; // Update the selected currency
                            });
                          },
                        ),
                      ),
                    ),
                    // Second row, second column: Converted value
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: Text(
                          userAnswer,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer to push the buttons to the bottom
              const Spacer(),
              // Buttons section
              Container(
                color: Colors.black, // Background color for the buttons section
                padding: const EdgeInsets.all(10),
                child: CalculatorButtons(
                    buttons: buttons,
                    userQuestion: userQuestion,
                    onButtonPressed: (String buttonText) {
                      setState(() {
                        userQuestion += buttonText;
                      });
                    },
                    onClearPressed: () {
                      setState(() {
                        userQuestion = '';
                        userAnswer = '';
                      });
                    },
                    onEqualPressed: () async {
                      if (userQuestion.isNotEmpty) {
                        try {
                          // Check if exchangeRates is empty and fetch if necessary
                          if (exchangeRates.isEmpty) {
                            await fetchExchangeRates();
                          }

                          double amount = double.parse(userQuestion);
                          double convertedValue = convertCurrency(
                              selectedCurrency1, selectedCurrency2, amount);

                          setState(() {
                            userAnswer = convertedValue.toStringAsFixed(2);
                          });
                        } catch (e) {
                          setState(() {
                            userAnswer = "Invalid input";
                          });
                        }
                      }
                    },
                    onDeletePressed: () {
                      setState(() {
                        if (userQuestion.isNotEmpty) {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        }
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) {
    return ['+', '-', '*', '/', '%', 'DEL', 'x'].contains(x);
  }

  void equalPressed({
    required String userQuestion,
    required Function(String) updateAnswer,
  }) {
    if (userQuestion.isEmpty || isOperator(userQuestion[0])) {
      return;
    }

    try {
      String finalQuestion = userQuestion.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval == eval.toInt()) {
        updateAnswer(eval.toInt().toString());
      } else {
        updateAnswer(eval.toString());
      }
    } catch (e) {
      updateAnswer("Oh no");
    }
  }
}
