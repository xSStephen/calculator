import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentPageIndex; // Add a parameter to track the current page

  const NavBar({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 40),
      color: Colors.black, // Background color for the header
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Calculator",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: currentPageIndex == 0 ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(width: 20), // Space between the two texts
          Text(
            "Tools",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: currentPageIndex == 1 ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
