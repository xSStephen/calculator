import 'package:calculator/modules/nav_bar.dart';
import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final Widget body; // The main content of the page
  final bool showNavBar; // Whether to show the NavBar
  final EdgeInsetsGeometry padding; // Custom padding for the page
  final int currentPageIndex; // Track the current page index

  const PageTemplate({
    super.key,
    required this.body,
    this.showNavBar = false,
    this.padding = const EdgeInsets.all(12.0),
    this.currentPageIndex = 0, // Default to the first page
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Scaffold(
        appBar: showNavBar
            ? AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                title: NavBar(
                    currentPageIndex:
                        currentPageIndex), // Pass currentPageIndex to NavBar
              )
            : null,
        backgroundColor: Colors.black, // Set a consistent background color
        body: body, // Display the page content
      ),
    );
  }
}
