import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/task_model.dart';
import '../../state_management/providers.dart';
import '../../widgets/custom_bottom_nav_bar_widget.dart';

// TODO: Track who assigned and when
// TODO 11: Search bar for tasks

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(firestore);
    final auth = ref.read(firebaseAuth);

    // Get all tasks for company
    Future<List<dynamic>> getTasks() async {
      final tasks = await db.getUserTasks(userID: auth.user!.uid);
      // sort tasks by due date
      tasks.sort((a, b) => a.taskDueDate.compareTo(b.taskDueDate));
      return tasks;
    }

    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        title: const Text('Tasks'),
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
              print(snapshot.error);
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
                    return ListTile(
                      title: Text(task.taskHeading),
                      subtitle: Text(task.taskDueDate),
                      onTap: () {
                        Beamer.of(context).beamToNamed(
                          '/task-page',
                          data: task,
                        );
                      },
                    );
                  }).toList(),
                ),
                ExpansionTile(
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
                          7)
                      .map<Widget>((task) {
                    return ListTile(
                      title: Text(task.taskHeading),
                      subtitle: Text(task.taskDueDate),
                      onTap: () {
                        Beamer.of(context).beamToNamed(
                          '/task-page',
                          data: task,
                        );
                      },
                    );
                  }).toList(),
                ),
                ExpansionTile(
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
                    return ListTile(
                      title: Text(task.taskHeading),
                      subtitle: Text(task.taskDueDate),
                      onTap: () {
                        Beamer.of(context).beamToNamed(
                          '/task-page',
                          data: task,
                        );
                      },
                    );
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
