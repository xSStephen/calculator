import 'package:calculator/modules/nav_bar.dart';
import 'package:flutter/material.dart';

// This page serves as a template for all the pages of the app
class PageTemplate extends StatelessWidget {
  final Widget body; // The main content of the page
  final bool showNavBar; // Whether to show the NavBar in the AppBar
  final EdgeInsetsGeometry padding; // Custom padding for the page
  final String currentPage; // Add a parameter to track the current page

  const PageTemplate({
    super.key,
    required this.body, // Pass the page content
    this.showNavBar = false, // Default to showing the NavBar
    this.padding = const EdgeInsets.all(12.0), // Default padding
    this.currentPage = '0', // Default to no specific page
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding, // Apply consistent padding
      child: Scaffold(
        appBar: showNavBar
            ? AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                title: NavBar(
                    currentPage: currentPage), // Pass currentPage to NavBar
              )
            : null, // Optionally hide the AppBar
        backgroundColor: Colors.green, // Set a consistent background color
        body: body, // Display the page content
      ),
    );
  }
}
