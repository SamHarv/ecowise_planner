import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

// TODO 3: manipulate views depending on user access level

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: '/home', // as below
  initialPath: '/home', // check auth status and redirect to '/home' or '/login'
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/home': (context, state, data) {
        return const BeamPage(
          key: ValueKey('home'),
          type: BeamPageType.fadeTransition,
          title: 'Project Planner',
          child: HomePage(),
        );
      },
      // TODO 2: add auth pages
      '/sign-in': (context, state, data) {
        return const BeamPage(
          key: ValueKey('sign-in'),
          type: BeamPageType.fadeTransition,
          title: 'Sign In - Plans',
          child: SignInPage(),
        );
      },
      '/sign-up': (context, state, data) {
        return const BeamPage(
          key: ValueKey('sign-up'),
          type: BeamPageType.fadeTransition,
          title: 'Sign Up - Plans',
          child: SignUpPage(),
        );
      },
      '/forgot-password': (context, state, data) {
        return const BeamPage(
          key: ValueKey('forgot-password'),
          type: BeamPageType.fadeTransition,
          title: 'Forgot Password - Plans',
          child: ForgotPasswordPage(),
        );
      },
      '/tasks': (context, state, data) {
        return const BeamPage(
          key: ValueKey('task-page'),
          type: BeamPageType.noTransition,
          title: 'Tasks',
          //'$data.taskHeading',
          child: TasksPage(),
          //TaskPage(task: data as Task, taskID: data.taskID),
        );
      },
      '/projects': (context, state, data) {
        return const BeamPage(
          key: ValueKey('projects'),
          type: BeamPageType.noTransition,
          title: 'Projects',
          child: ProjectsPage(),
        );
      },
      '/settings': (context, state, data) {
        return const BeamPage(
          key: ValueKey('settings'),
          type: BeamPageType.noTransition,
          title: 'Settings',
          child: SettingsPage(),
        );
      },
      '/search': (context, state, data) {
        return const BeamPage(
          key: ValueKey('search'),
          type: BeamPageType.noTransition,
          title: 'Search',
          child: SearchPage(),
        );
      },
      '/alerts': (context, state, data) {
        return const BeamPage(
          key: ValueKey('alerts'),
          type: BeamPageType.noTransition,
          title: 'Alerts',
          child: AlertsPage(),
        );
      },
    },
  ).call,
);
