import 'package:flutter/material.dart';

// This page will manage the Basic Calculator UI and functionality
// It will include a simple calculator with basic operations like addition, subtraction, multiplication, and division.

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({super.key});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  // store the displayed value
  String displayText = "0";

  // store the numbers and operator
  double? firstNumber;
  String? operator;

  // list of buttons for the calculator
  final List<String> buttonLabels = [
    "AC",
    "DEL",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "N/A",
    "0",
    ".",
    "="
  ];

  // method to handle button press
  void onButtonPressed(String label) {
    setState(() {
      if (label == "AC") {
        // Clear everything
        displayText = "0";
        firstNumber = null;
        operator = null;
      } else if (label == "DEL") {
        // Remove the last character
        displayText = displayText.length > 1
            ? displayText.substring(0, displayText.length - 1)
            : "0";
      } else if (label == "+" || label == "-" || label == "x" || label == "÷") {
        // Store the first number and the operator
        firstNumber = double.tryParse(displayText);
        operator = label;
        displayText = "0";
      } else if (label == "=") {
        // Perform the calculation
        if (firstNumber != null && operator != null) {
          double secondNumber = double.tryParse(displayText) ?? 0;
          if (operator == "+") {
            displayText = (firstNumber! + secondNumber).toString();
          } else if (operator == "-") {
            displayText = (firstNumber! - secondNumber).toString();
          } else if (operator == "x") {
            displayText = (firstNumber! * secondNumber).toString();
          } else if (operator == "÷") {
            displayText = secondNumber != 0
                ? (firstNumber! / secondNumber).toString()
                : "Error"; // Handle division by zero
          }
          firstNumber = null; // Reset after calculation
          operator = null;
        }
      } else {
        // Append the label to the display text
        if (displayText == "0") {
          displayText = label;
        } else {
          displayText += label;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Calculator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
        toolbarHeight: 50,
      ),
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.black,
            alignment: Alignment.center,
            child: Text(
              displayText,
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemCount: 20,
                itemBuilder: (context, index) {
                  final label = buttonLabels[index];
                  return ElevatedButton(
                      onPressed: () {
                        // handle button press
                        onButtonPressed(label);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      child: Text(
                        label,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ));
                }),
          ))
        ],
      ),
    );
  }
}
