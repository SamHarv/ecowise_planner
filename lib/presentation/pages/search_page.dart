import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/custom_bottom_nav_bar_widget.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // search bar
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text('Search Page Coming Soon'),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
