import 'package:calculator/modules/page_template.dart';
import 'package:flutter/material.dart';

class OtherTools extends StatelessWidget {
  const OtherTools({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a map of calculator types and their corresponding actions
    final Map<String, VoidCallback> calculators = {
      'Currency': () =>
          Navigator.pushNamed(context, '/tools/currency_calculator'),
    };

    return PageTemplate(
      currentPageIndex: 1,
      showNavBar: false,
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: calculators.keys.length,
        itemBuilder: (context, index) {
          final calculatorName = calculators.keys.elementAt(index);
          final onPressed = calculators[calculatorName];

          return ElevatedButton(
            onPressed: onPressed,
            child: Text(calculatorName),
          );
        },
      ),
    );
  }
}
