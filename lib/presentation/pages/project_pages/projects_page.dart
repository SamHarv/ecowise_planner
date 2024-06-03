import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/project_model.dart';
import '../../state_management/providers.dart';
import '../../widgets/custom_bottom_nav_bar_widget.dart';

// TODO 55: add search bar for projects

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);

    Future<List<Project>> getProjects() async {
      final projects = await db.getProjects(userID: auth.user!.uid);
      return projects;
    }

    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        title: const Text('Projects'),
      ),
      body: FutureBuilder(
        future: getProjects(), // TODO: Getting snapshot error
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred! ${snapshot.error}'),
            );
          }
          final projects = snapshot.data!;
          if (projects.isEmpty) {
            return const Center(
              child: Text('No Projects Found!'),
            );
          }
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ListTile(
                title: Text(project.projectTitle),
                subtitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.primaryClientName),
                      Text(project.projectDescription),
                      Text(
                        '${project.projectAddress1}, ${project.projectCity}, ${project.projectState}\n${project.projectPostCode}, Australia',
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: project.projectStatus == "In Progress"
                        ? Colors.green
                        : Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      project.projectStatus,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  Beamer.of(context).beamToNamed(
                    '/project-page',
                    data: project,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Beamer.of(context).beamToNamed('/new-project');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
