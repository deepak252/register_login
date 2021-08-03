import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const TextInputWidget({ 
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.onChanged,
    this.obscureText,
    this.keyboardType,
    this.validator,  
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(
          fontSize: 14,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            labelText: labelText,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixIconConstraints: BoxConstraints(
            maxWidth: 30,
            minWidth: 30
          )
        ),
      ),
    );
  }
}