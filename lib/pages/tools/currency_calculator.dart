import 'package:calculator/modules/page_template.dart';
import 'package:calculator/modules/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

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
                                  Text(
                                    currency[
                                        'name']!, // Full name of the currency
                                    style: const TextStyle(color: Colors.white),
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
                        color: Colors.blue,
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
                        color: Colors.orange,
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                          value: selectedCurrency2,
                          dropdownColor: Colors.orange,
                          style: const TextStyle(color: Colors.white),
                          items: currencies.map((currency) {
                            return DropdownMenuItem<String>(
                              value: currency[
                                  'short'], // Use the 'short' value as the key
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currency[
                                        'name']!, // Full name of the currency
                                    style: const TextStyle(color: Colors.white),
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
                        color: Colors.purple,
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
                padding: const EdgeInsets.all(10), // Add some padding
                child: GridView.builder(
                  shrinkWrap: true, // Prevents GridView from expanding
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns in the grid
                  ),
                  itemCount:
                      buttons.length, // Total number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    return buttons[index] == 'icon_del'
                        ? MyButton(
                            buttonTapped: () {
                              setState(() {
                                if (userQuestion.isNotEmpty) {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                }
                              });
                            },
                            icon: Icons.backspace_outlined,
                            color: Colors.grey[850],
                            textColor: Colors.orange,
                            buttonText: buttons[index],
                          )
                        : buttons[index] == 'C'
                            ? MyButton(
                                buttonText: buttons[index],
                                color: Colors.grey[850],
                                textColor: Colors.orange,
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = '';
                                    userAnswer = '';
                                  });
                                },
                              )
                            : buttons[index] == '='
                                ? MyButton(
                                    buttonText: buttons[index],
                                    color: Colors.orange,
                                    textColor: Colors.white,
                                    buttonTapped: () {
                                      setState(() {
                                        equalPressed();
                                      });
                                    },
                                  )
                                : MyButton(
                                    buttonTapped: () {
                                      setState(() {
                                        if (isOperator(buttons[index]) &&
                                            userQuestion.isEmpty) {
                                          return;
                                        }
                                        userQuestion += buttons[index];
                                      });
                                    },
                                    buttonText: buttons[index],
                                    color: isOperator(buttons[index])
                                        ? Colors.grey[850]
                                        : Colors.grey[850],
                                    textColor: isOperator(buttons[index])
                                        ? Colors.orange
                                        : Colors.white,
                                  );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) {
    // Check if the button text is an operator
    if (x == '+' ||
        x == '-' ||
        x == '*' ||
        x == '/' ||
        x == '%' ||
        x == 'DEL' ||
        x == 'x') {
      return true;
    } else {
      return false;
    }
  }

  bool isEqual(String x) {
    // Check if the button text is equal to '='
    if (x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    // Check if the input is empty or starts with an operator
    if (userQuestion.isEmpty || isOperator(userQuestion[0])) {
      return;
    }

    try {
      // Replace 'x' with '*' for multiplication
      String finalQuestion = userQuestion.replaceAll('x', '*');

      // Parse and evaluate the expression
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Update the answer
      setState(() {
        // Check if the result is a whole number
        if (eval == eval.toInt()) {
          userAnswer = eval.toInt().toString(); // Display as an integer
        } else {
          userAnswer = eval.toString(); // Display as a double
        }
      });
    } catch (e) {
      // Handle any parsing or evaluation errors
      setState(() {
        userAnswer = "Oh no";
      });
    }
  }
}
