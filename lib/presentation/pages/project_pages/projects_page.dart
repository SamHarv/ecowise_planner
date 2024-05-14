import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/project_model.dart';
import '../../state_management/providers.dart';
import '../../widgets/custom_bottom_nav_bar_widget.dart';

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
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    final user = db.getUser(userID: auth.user!.uid);

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
        future: getProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
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
                      Text(
                          '${project.primaryClientName} - ${project.projectAddress1}'),
                      Text(project.projectDescription),
                      Text(
                        '${project.projectCity}, ${project.projectState}\n${project.projectPostCode}, Australia',
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
                  Beamer.of(context)
                      .beamToNamed('project-page'); // TODO 00: fix
                },
              );
            },
          );
        },
      ),

      // ListView.builder(
      //   itemCount: 10,
      //   itemBuilder: (context, index) {
      //     // get projects from db to build in listview

      //     final projects =
      //         db.streamProjects(companyID: user.companyID) as List<Project>;
      //     for (final project in projects) {
      //       return ListTile(
      //         title: Text(project.projectTitle),
      //         subtitle: Column(
      //           children: [
      //             Text(
      //                 '${project.primaryClientName} - ${project.projectAddress1}'),
      //             Text(project.projectDescription),
      //             Text(
      //               '${project.projectCity}, ${project.projectState}\n${project.projectPostCode}, Australia',
      //             ),
      //             Text(
      //               project.projectStatus,
      //               style: const TextStyle(color: Colors.green),
      //             ),
      //           ],
      //         ),
      //         trailing: Container(
      //           width: 100,
      //           height: 50,
      //           color: Colors.green,
      //           child: Center(
      //             child: Text(
      //               project.projectStatus,
      //               style: const TextStyle(color: Colors.white),
      //             ),
      //           ),
      //         ),
      //         onTap: () {
      //           Beamer.of(context).beamToNamed(''); // TODO 00: fix
      //         },
      //       );
      //     }
      //     return const Text("No Projects Found!");
      //   },
      // ),
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
