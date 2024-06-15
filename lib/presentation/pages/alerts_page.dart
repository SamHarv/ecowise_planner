import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/bottom_nav_bar_menu_widget.dart';
import '../widgets/custom_bottom_nav_bar_widget.dart';

class AlertsPage extends ConsumerStatefulWidget {
  const AlertsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlertsPageState();
}

class _AlertsPageState extends ConsumerState<AlertsPage> {
  @override
  void initState() {
    isSelected = [false, false, false, true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
