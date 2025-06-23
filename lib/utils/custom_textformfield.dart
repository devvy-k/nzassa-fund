import 'package:flutter/material.dart';

class CustomTextformfield extends StatefulWidget {
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
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      obscureText: _obscureText,
      keyboardType: widget.keyBoardType == 'text'
          ? TextInputType.text
          : widget.keyBoardType == 'number'
              ? TextInputType.number
              : widget.keyBoardType == 'phone'
                  ? TextInputType.phone
                  : TextInputType.emailAddress,
      validator: widget.contentRequired ? widget.validator : null,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
