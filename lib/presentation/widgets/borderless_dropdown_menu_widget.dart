import 'package:flutter/material.dart';

class BorderlessDropdownMenuWidget extends StatelessWidget {
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final void Function(dynamic)? onSelected;
  final double width;
  final String label;
  final String hintText;

  const BorderlessDropdownMenuWidget({
    super.key,
    required this.dropdownMenuEntries,
    required this.onSelected,
    required this.width,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      width: width,
      dropdownMenuEntries: dropdownMenuEntries,
      onSelected: onSelected,
      enableFilter: true,
      hintText: hintText,
    );
  }
}
