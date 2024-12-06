import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropdownMenuWidget extends ConsumerWidget {
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final void Function(dynamic)? onSelected;
  final double width;
  final String label;

  const CustomDropdownMenuWidget({
    super.key,
    required this.dropdownMenuEntries,
    required this.onSelected,
    required this.width,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownMenu(
      width: width,
      dropdownMenuEntries: dropdownMenuEntries,
      onSelected: onSelected,
      enableFilter: false,
      label: Text(label),
    );
  }
}
