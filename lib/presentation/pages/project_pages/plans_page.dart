import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/presentation/widgets/project_bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/project_model.dart';
import '../../widgets/bottom_nav_bar_menu_widget.dart';

class PlansPage extends ConsumerStatefulWidget {
  final Project project;
  final String projectID;

  const PlansPage({
    super.key,
    required this.project,
    required this.projectID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlansPageState();
}

class _PlansPageState extends ConsumerState<PlansPage> {
  @override
  void initState() {
    isSelected = [false, true, false, false, false];
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
        title: const Text('Plans'),
      ),
      body: Center(
        child: Text(
          'Plans Page for ${widget.project.projectTitle} Coming Soon\n\n'
          'Plans - include links to Drive',
        ),
      ),
      bottomNavigationBar: const ProjectBottomNavBarWidget(),
    );
  }
}
