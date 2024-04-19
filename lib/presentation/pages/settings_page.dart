import 'package:beamer/beamer.dart';
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
        title: InkWell(
          onTap: () => Beamer.of(context).beamToNamed('/sign-in'),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                  //Image.asset('images/d-train.png'),
                ),
              ),
              const SizedBox(width: 8),
              const Text('D-Train'),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text('Settings Page Coming Soon'),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
