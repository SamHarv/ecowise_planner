import 'package:flutter/material.dart';

import 'bottom_nav_bar_menu_widget.dart';

class CustomBottomNavBarWidget extends StatefulWidget {
  const CustomBottomNavBarWidget({super.key});

  @override
  State<CustomBottomNavBarWidget> createState() =>
      _CustomBottomNavBarWidgetState();
}

class _CustomBottomNavBarWidgetState extends State<CustomBottomNavBarWidget> {
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
            label: 'Tasks',
            navDestination: 'tasks',
          ),
          BottomNavBarMenuWidget(
            index: 1,
            icon: Icons.dashboard,
            label: 'Projects',
            navDestination: 'projects',
          ),
          BottomNavBarMenuWidget(
            index: 2,
            icon: Icons.storage,
            label: 'Resources',
            navDestination: 'home',
          ),
          BottomNavBarMenuWidget(
            index: 3,
            icon: Icons.notifications,
            label: 'Alerts',
            navDestination: 'alerts',
          ),
          BottomNavBarMenuWidget(
            index: 4,
            icon: Icons.settings,
            label: 'Settings',
            navDestination: 'settings',
          ),
        ],
      ),
    );
  }
}
