import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/presentation/widgets/project_bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/project_model.dart';
import '../../widgets/bottom_nav_bar_menu_widget.dart';

class SchedulePage extends ConsumerStatefulWidget {
  final Project project;
  final String projectID;

  const SchedulePage({
    super.key,
    required this.project,
    required this.projectID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  @override
  void initState() {
    isSelected = [true, false, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Beamer.of(context).beamToNamed('/projects');
            }),
        title: const Text('Schedule'),
      ),
      body: Center(
        child: Text(
          'Schedule Page for ${widget.project.projectTitle} Coming Soon\n\n'
          'Schedule - tasks & subtasks',
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavBarWidget(),
    );
  }
}
