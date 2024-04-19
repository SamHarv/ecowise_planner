import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/custom_bottom_nav_bar_widget.dart';

class AlertsPage extends ConsumerWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        title: const Text('Alerts'),
      ),
      body: const Center(
        child: Text('Alerts Page Coming Soon'),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
