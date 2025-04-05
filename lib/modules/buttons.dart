import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.buttonText,
    required this.color,
    required this.textColor,
    this.icon,
  });

  final dynamic color;
  final dynamic textColor;
  final String buttonText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: color,
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    color: textColor,
                  )
                : Text(
                    buttonText,
                    style: TextStyle(color: textColor, fontSize: 30),
                  ),
          ),
        ),
      ),
    );
  }
}
