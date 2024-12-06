import 'package:flutter/material.dart';

import 'bottom_nav_bar_menu_widget.dart';

List<bool> projIsSelected = [true, false, false, false, false];

class ProjectBottomNavBarWidget extends StatefulWidget {
  const ProjectBottomNavBarWidget({super.key});

  @override
  State<ProjectBottomNavBarWidget> createState() =>
      _ProjectBottomNavBarWidgetState();
}

class _ProjectBottomNavBarWidgetState extends State<ProjectBottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.black54,
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavBarMenuWidget(
            index: 0,
            icon: Icons.task,
            label: 'Schedule',
            navDestination: 'schedule-page',
          ),
          BottomNavBarMenuWidget(
            index: 1,
            icon: Icons.file_present,
            label: 'Plans',
            navDestination: 'plans-page',
          ),
          BottomNavBarMenuWidget(
            index: 2,
            icon: Icons.attach_money,
            label: 'Proposals',
            navDestination: 'proposals-page',
          ),
          BottomNavBarMenuWidget(
            index: 3,
            icon: Icons.people,
            label: 'Management',
            navDestination: 'management-page',
          ),
          BottomNavBarMenuWidget(
            index: 4,
            icon: Icons.settings,
            label: 'Info',
            navDestination: 'project-page',
          ),
        ],
      ),
    );
  }
}
