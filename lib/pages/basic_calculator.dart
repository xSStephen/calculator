import 'package:calculator/modules/buttons.dart';
import 'package:flutter/material.dart';

// This page will manage the Basic Calculator UI and functionality
// It will include a simple calculator with basic operations like addition, subtraction, multiplication, and division.

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({super.key});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
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
    'ANS',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns in the grid
              ),
              itemCount: buttons.length, // Total number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                return buttons[index] == 'icon_del'
                    ? MyButton(
                        icon:
                            Icons.backspace_outlined, // Use the backspace icon
                        color: Colors.grey[850],
                        textColor: Colors.orange,
                        buttonText: buttons[index],
                      )
                    : MyButton(
                        buttonText: buttons[index],
                        color: buttons[index] == '='
                            ? Colors.orange
                            : isOperator(buttons[index])
                                ? Colors.grey[850]
                                : Colors.grey[850],
                        textColor: isOperator(buttons[index])
                            ? Colors.orange
                            : Colors.white,
                      );
              },
            ),
          )
        ],
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
        x == 'C' ||
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
}
