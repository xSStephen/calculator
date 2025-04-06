import 'package:flutter/material.dart';
import 'package:calculator/modules/nav_bar.dart';

class OtherTools extends StatelessWidget {
  const OtherTools({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          NavBar(), // Display the NavBar here
          Expanded(
            child: Center(
              child: Text(
                'other_tools page',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
