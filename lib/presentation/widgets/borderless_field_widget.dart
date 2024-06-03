import 'package:flutter/material.dart';

class BorderlessFieldWidget extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final Function(String)? onChanged;
  final Text? label;
  final int? maxLines;
  final int? minLines;
  final TextInputType? inputType;

  const BorderlessFieldWidget({
    super.key,
    required this.width,
    required this.controller,
    required this.hintText,
    required this.fontSize,
    this.onChanged,
    this.label,
    this.maxLines,
    this.minLines,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          showCursor: true,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
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
          textCapitalization: TextCapitalization.sentences,
          keyboardType: inputType ?? TextInputType.text,
        ),
      ),
    );
  }
}
