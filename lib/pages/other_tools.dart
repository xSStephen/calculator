import 'package:calculator/modules/page_template.dart';
import 'package:flutter/material.dart';

class OtherTools extends StatelessWidget {
  const OtherTools({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      currentPage: "tools",
      showNavBar: false,
      body: Text('keep the page green for debug purposes'),
    );
  }
}
