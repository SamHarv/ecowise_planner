import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/project_model.dart';
import '../../state_management/providers.dart';
import '../../widgets/bottom_nav_bar_menu_widget.dart';
import '../../widgets/custom_bottom_nav_bar_widget.dart';
import '../../widgets/custom_field_widget.dart';

// Sub task:
// Due date
// Project title
// Check off
// Description
// Attachment

// Layer betweem task and project - schedule task
// Hide section of schedule

// Photo attachment for task

// Project -

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  final _searchTextController = TextEditingController();
  @override
  void initState() {
    isSelected = [true, false, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(firestore);
    final auth = ref.read(firebaseAuth);
    String searchTerm = _searchTextController.text.trim().toLowerCase();

    // Get all tasks for company
    Future<List<dynamic>> getTasks() async {
      final tasks = await db.getUserTasks(userID: auth.user!.uid);
      // sort tasks by due date
      // tasks.sort((a, b) => a.taskDueDate.compareTo(b.taskDueDate));
      return tasks;
    }

    Future<Project> getProject(String projectID) async {
      final companyID = await db.getCompanyID(userID: auth.user!.uid);
      final project =
          await db.getProject(projectID: projectID, companyID: companyID);
      return project;
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
            hintText: 'Search Tasks',
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
        ),
      ),
      body: FutureBuilder(
          future: getTasks(),
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
            final tasks = snapshot.data!;
            if (tasks.isEmpty) {
              return const Center(
                child: Text('No Tasks Found!'),
              );
            }
            return ListView(
              children: [
                ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text(
                    "Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Tasks where due date is within one day
                  children: tasks
                      .where((task) =>
                          DateTime.parse(task.taskDueDate)
                              .difference(DateTime.now())
                              .inDays <=
                          1)
                      .map<Widget>((task) {
                    return FutureBuilder(
                        future: getProject(task.projectID),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text('An error occurred! ${snapshot.error}'),
                            );
                          }
                          final project = snapshot.data!;

                          if (searchTerm != "") {
                            if (!task.taskHeading
                                    .toLowerCase()
                                    .contains(searchTerm) &&
                                !task.notes!
                                    .toLowerCase()
                                    .contains(searchTerm) &&
                                !project.projectTitle
                                    .toLowerCase()
                                    .contains(searchTerm)) {
                              return const SizedBox.shrink();
                            }
                          }
                          return ListTile(
                            title: Text(task.taskHeading),
                            subtitle: Text(
                                "Due: ${task.taskDueDate.toString().substring(8, 10)}-"
                                "${task.taskDueDate.toString().substring(5, 7)}-"
                                "${task.taskDueDate.toString().substring(0, 4)}"),
                            onTap: () {
                              Beamer.of(context).beamToNamed(
                                '/task-page',
                                data: task,
                              );
                            },
                            trailing: Text(
                              project.projectTitle,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        });
                  }).toList(),
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text(
                    "Coming Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Tasks where due date is tomorrow
                  children: tasks
                      .where((task) =>
                          DateTime.parse(task.taskDueDate)
                                  .difference(DateTime.now())
                                  .inDays <=
                              7 &&
                          DateTime.parse(task.taskDueDate)
                                  .difference(DateTime.now())
                                  .inDays >
                              1)
                      .map<Widget>((task) {
                    return FutureBuilder(
                        future: getProject(task.projectID),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text('An error occurred! ${snapshot.error}'),
                            );
                          }
                          final project = snapshot.data!;

                          if (searchTerm != "") {
                            if (!task.taskHeading
                                    .toLowerCase()
                                    .contains(searchTerm) &&
                                !task.notes!
                                    .toLowerCase()
                                    .contains(searchTerm) &&
                                !project.projectTitle
                                    .toLowerCase()
                                    .contains(searchTerm)) {
                              return const SizedBox.shrink();
                            }
                          }
                          return ListTile(
                            title: Text(task.taskHeading),
                            subtitle: Text(
                              "Due: ${task.taskDueDate.toString().substring(8, 10)}-"
                              "${task.taskDueDate.toString().substring(5, 7)}-"
                              "${task.taskDueDate.toString().substring(0, 4)}",
                            ),
                            onTap: () {
                              Beamer.of(context).beamToNamed(
                                '/task-page',
                                data: task,
                              );
                            },
                            trailing: Text(
                              project.projectTitle,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        });
                  }).toList(),
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text(
                    "Future",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Tasks where due date is later
                  children: tasks
                      .where((task) =>
                          DateTime.parse(task.taskDueDate)
                              .difference(DateTime.now())
                              .inDays >
                          7)
                      .map<Widget>((task) {
                    return FutureBuilder(
                        future: getProject(task.projectID),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text('An error occurred! ${snapshot.error}'),
                            );
                          }
                          final project = snapshot.data!;

                          if (searchTerm != "") {
                            if (!task.taskHeading
                                    .toLowerCase()
                                    .contains(searchTerm) &&
                                !task.notes!
                                    .toLowerCase()
                                    .contains(searchTerm) &&
                                !project.projectTitle
                                    .toLowerCase()
                                    .contains(searchTerm)) {
                              return const SizedBox.shrink();
                            }
                          }
                          return ListTile(
                            title: Text(task.taskHeading),
                            subtitle: Text(
                                "Due: ${task.taskDueDate.toString().substring(8, 10)}-"
                                "${task.taskDueDate.toString().substring(5, 7)}-"
                                "${task.taskDueDate.toString().substring(0, 4)}"),
                            onTap: () {
                              Beamer.of(context).beamToNamed(
                                '/task-page',
                                data: task,
                              );
                            },
                            trailing: Text(
                              project.projectTitle,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        });
                  }).toList(),
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Beamer.of(context).beamToNamed('/new-task');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
