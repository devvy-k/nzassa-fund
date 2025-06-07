import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final String keyBoardType;
  final bool contentRequired;
  final int maxLines;
  final String? Function(String?)? validator;

  const CustomTextformfield({
    super.key,
    required this.hint,
    required this.controller,
    required this.contentRequired,
    this.maxLines = 1,
    this.keyBoardType = 'text',
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: keyBoardType == 'text'
          ? TextInputType.text
          : keyBoardType == 'number'
              ? TextInputType.number
               : keyBoardType == 'phone'
                  ? TextInputType.phone
                    : TextInputType.emailAddress,
      validator: contentRequired ? validator : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }
}