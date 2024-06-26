import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDialogWidget extends ConsumerWidget {
  final String dialogHeading;
  // Content not limited to text (e.g. colour palette)
  final Widget? dialogContent;
  final List<Widget> dialogActions;

  const CustomDialogWidget(
      {super.key,
      required this.dialogHeading,
      this.dialogContent,
      required this.dialogActions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(
        dialogHeading,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      content: dialogContent,
      backgroundColor: Colors.black,
      actions: dialogActions,
    );
  }
}
