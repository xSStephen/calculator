import 'package:calculator/modules/page_template.dart';
import 'package:flutter/material.dart';

class OtherTools extends StatelessWidget {
  const OtherTools({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      showNavBar: false,
      body: Text('content'),
    );
  }
}
