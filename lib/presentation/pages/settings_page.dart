import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/custom_bottom_nav_bar_widget.dart';

// TODO 4: add account info, pricing, settings, etc.

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: CircleAvatar(
                child: Image.asset('images/d-train.png'),
              ),
            ),
            const SizedBox(width: 8),
            const Text('D-Train'),
          ],
        ),
      ),
      body: const Center(
        child: Text('Settings Page Coming Soon'),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
