import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../application/services/firebase_auth_service.dart';
import '../../presentation/pages/alerts_page.dart';
import '../../presentation/pages/forgot_password_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/projects_page.dart';
import '../../presentation/pages/search_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/sign_in_page.dart';
import '../../presentation/pages/sign_up_page.dart';
import '../../presentation/pages/tasks_page.dart';

// TODO 3: manipulate views depending on user access level

FirebaseAuthService auth = FirebaseAuthService();

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: auth.user == null ? '/sign-in' : '/home', // as below
  initialPath: auth.user == null
      ? '/sign-in'
      : '/home', // check auth status and redirect to '/home' or '/login'
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/home': (context, state, data) {
        return const BeamPage(
          key: ValueKey('home'),
          type: BeamPageType.noTransition,
          title: 'Project Planner',
          child: HomePage(),
        );
      },
      // TODO 2: add auth pages
      '/sign-in': (context, state, data) {
        return const BeamPage(
          key: ValueKey('sign-in'),
          type: BeamPageType.noTransition,
          title: 'Sign In - Plans',
          child: SignInPage(),
        );
      },
      '/sign-up': (context, state, data) {
        return const BeamPage(
          key: ValueKey('sign-up'),
          type: BeamPageType.noTransition,
          title: 'Sign Up - Plans',
          child: SignUpPage(),
        );
      },
      '/forgot-password': (context, state, data) {
        return const BeamPage(
          key: ValueKey('forgot-password'),
          type: BeamPageType.noTransition,
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
