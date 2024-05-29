import 'package:flutter/material.dart';

class BorderlessFieldWidget extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final Function(String)? onChanged;
  final Text? label;

  const BorderlessFieldWidget({
    super.key,
    required this.width,
    required this.controller,
    required this.hintText,
    required this.fontSize,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            label: label,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}
