import 'package:calculator/modules/buttons.dart';
import 'package:calculator/modules/page_template.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/pages/other_tools.dart';

// This page will manage the Basic Calculator UI and functionality
// It will include a simple calculator with basic operations like addition, subtraction, multiplication, and division.

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({super.key});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  // User data
  String userQuestion = '';
  String userAnswer = '';

  // track active page
  int currentPageIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      currentPageIndex: currentPageIndex,
      showNavBar: true,
      body: PageView(
        controller: PageController(initialPage: 0),
        onPageChanged: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                )),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns in the grid
                    ),
                    itemCount:
                        buttons.length, // Total number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      return buttons[index] == 'icon_del'
                          ? MyButton(
                              // delete last number button
                              buttonTapped: () {
                                setState(() {
                                  if (userQuestion.isNotEmpty) {
                                    userQuestion = userQuestion.substring(
                                        0, userQuestion.length - 1);
                                  }
                                });
                              },
                              icon: Icons
                                  .backspace_outlined, // Use the backspace icon
                              color: Colors.grey[850],
                              textColor: Colors.orange,
                              buttonText: buttons[index],
                            )
                          : buttons[index] == 'C'
                              ? MyButton(
                                  // delete everything button
                                  buttonText: buttons[index],
                                  color: Colors.grey[850],
                                  textColor: Colors.orange,
                                  buttonTapped: () {
                                    setState(() {
                                      userQuestion = '';
                                      userAnswer = '';
                                    });
                                  })
                              : buttons[index] == '='
                                  ? MyButton(
                                      buttonText: buttons[index],
                                      color: Colors.orange,
                                      textColor: Colors.white,
                                      buttonTapped: () {
                                        setState(() {
                                          equalPressed();
                                        });
                                      })
                                  : MyButton(
                                      buttonTapped: () {
                                        setState(() {
                                          // Prevent operators as the first character
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

          // second page
          const OtherTools(),
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
        userAnswer = "You've forgot the number :(";
      });
    }
  }
}
