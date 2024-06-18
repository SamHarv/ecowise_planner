import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/presentation/widgets/bottom_nav_bar_menu_widget.dart';
import 'package:ecowise_planner/presentation/widgets/custom_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/project_model.dart';
import '../../state_management/providers.dart';
import '../../widgets/custom_bottom_nav_bar_widget.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends ConsumerState<ProjectsPage> {
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    isSelected = [false, false, true, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    String searchTerm = _searchTextController.text.trim().toLowerCase();

    Future<List<Project>> getProjects() async {
      final projects = await db.getProjects(userID: auth.user!.uid);
      // sort projects by due date
      projects.sort((a, b) => a.projectDueDate.compareTo(b.projectDueDate));
      return projects;
    }

    return Scaffold(
      appBar: AppBar(
          shape: const Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0),
          ),
          centerTitle: false,
          title: SizedBox(
            height: 35,
            child: CustomFieldWidget(
              hintText: 'Search Projects',
              textController: _searchTextController,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text,
              width: double.infinity,
              onChanged: (value) {
                setState(() {
                  searchTerm = value.toLowerCase();
                });
              },
            ),
          )),
      body: FutureBuilder(
        future: getProjects(),
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
              if (searchTerm.toLowerCase() != "") {
                if (!project.projectTitle.toLowerCase().contains(searchTerm) &&
                    !project.primaryClientName
                        .toLowerCase()
                        .contains(searchTerm) &&
                    !project.projectDescription
                        .toLowerCase()
                        .contains(searchTerm) &&
                    !project.projectAddress1
                        .toLowerCase()
                        .contains(searchTerm) &&
                    !project.projectCity.toLowerCase().contains(searchTerm) &&
                    !project.projectState.toLowerCase().contains(searchTerm) &&
                    !project.projectPostCode
                        .toLowerCase()
                        .contains(searchTerm) &&
                    !project.projectStatus.toLowerCase().contains(searchTerm)) {
                  return const SizedBox.shrink();
                }
              }

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
