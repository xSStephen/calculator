import 'package:flutter/material.dart';
import 'package:calculator/modules/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorButtons extends StatelessWidget {
  final List<String> buttons;
  final String userQuestion;
  final Function(String) onButtonPressed;
  final VoidCallback onClearPressed;
  final VoidCallback onEqualPressed;
  final VoidCallback onDeletePressed;

  const CalculatorButtons({
    Key? key,
    required this.buttons,
    required this.userQuestion,
    required this.onButtonPressed,
    required this.onClearPressed,
    required this.onEqualPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: buttons.length,
      itemBuilder: (BuildContext context, int index) {
        return buttons[index] == 'icon_del'
            ? MyButton(
                buttonTapped: onDeletePressed,
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
                    buttonTapped: onClearPressed,
                  )
                : buttons[index] == '='
                    ? MyButton(
                        buttonText: buttons[index],
                        color: Colors.orange,
                        textColor: Colors.white,
                        buttonTapped: onEqualPressed,
                      )
                    : MyButton(
                        buttonTapped: () {
                          if (isOperator(buttons[index]) &&
                              userQuestion.isEmpty) {
                            return;
                          }
                          onButtonPressed(buttons[index]);
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
    );
  }

  bool isOperator(String x) {
    return ['+', '-', '*', '/', '%', 'DEL', 'x'].contains(x);
  }

  bool isEqual(String x) {
    return x == '=';
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
