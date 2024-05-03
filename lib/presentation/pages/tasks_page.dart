import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/custom_bottom_nav_bar_widget.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempMap = {
      'Now': [
        'Task 1',
        'Task 2',
        'Task 3',
        'Task 4',
        'Task 5',
        'Task 6',
      ],
      'Coming Up': [
        'Task 7',
        'Task 8',
        'Task 9',
        'Task 10',
        'Task 11',
        'Task 12',
      ],
      'Future': [
        'Task 13',
        'Task 14',
        'Task 15',
        'Task 16',
        'Task 17',
        'Task 18',
      ],
    };
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        title: const Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: tempMap.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              tempMap.keys.elementAt(index),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: tempMap.values
                .elementAt(index)
                .map((e) => ListTile(title: Text(e)))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // TODO 11: add new task page
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
