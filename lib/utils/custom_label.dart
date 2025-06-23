import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String label;
  final double? fontSize;
  final Color? color;

  const CustomLabel({super.key, 
    required this.label,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: color,
          ),
        ),
      ],
    );
  }
}