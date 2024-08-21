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

// TextField(
//         controller: textController,
//         textInputAction: TextInputAction.next,
//         textCapitalization: textCapitalization,
//         decoration: InputDecoration(
//           labelText: hintText,
//           floatingLabelStyle: TextStyle(
//             color: Colors.grey[500],
//           ),
//           border: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.grey,
//             ),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.white,
//             ),
//           ),
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Colors.grey[500],
//           ),
//         ),
//       ),
