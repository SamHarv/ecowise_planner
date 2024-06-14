import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomFieldWidget extends ConsumerWidget {
  final TextEditingController textController;
  final String hintText;
  final TextCapitalization textCapitalization;
  final double width;
  final TextInputType keyboardType;
  final int maxLines;
  final void Function(String)? onChanged;

  const CustomFieldWidget({
    super.key,
    required this.textController,
    required this.hintText,
    required this.textCapitalization,
    required this.width,
    required this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      child: TextField(
        onChanged: onChanged,
        controller: textController,
        textInputAction: TextInputAction.next,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: 1,
        decoration: InputDecoration(
          labelText: hintText,
          floatingLabelStyle: TextStyle(
            color: Colors.grey[500],
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
