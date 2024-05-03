import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/custom_bottom_nav_bar_widget.dart';

// TODO 55: add search bar for projects
// TODO 11: add view project page with client. Add options to:
// Navigate to address with maps
// Email the client
// Call the client
// Take notes
// See costs related to project and time spent on project fir employees
// CRUD tasks related to project

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          shape: const Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0),
          ),
          centerTitle: false,
          title: const Text('Projects')),
      body: const Center(
        child: Text('Projects Page Coming Soon'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // TODO 11: add new project page
          Beamer.of(context).beamToNamed('/new-project');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
