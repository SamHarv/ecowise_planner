import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/presentation/pages/project_pages/new_project_page.dart';
import 'package:flutter/material.dart';

import '../../application/services/firebase_auth_service.dart';
import '../../presentation/pages/alerts_page.dart';
import '../../presentation/pages/company_rego_pages/company_registration_page.dart';
import '../../presentation/pages/auth_pages/forgot_password_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/company_rego_pages/join_company_page.dart';
import '../../presentation/pages/project_pages/management_page.dart';
import '../../presentation/pages/project_pages/project_page.dart';
import '../../presentation/pages/project_pages/projects_page.dart';
import '../../presentation/pages/project_pages/plans_page.dart';
import '../../presentation/pages/project_pages/proposals_page.dart';
import '../../presentation/pages/project_pages/schedule_page.dart';
import '../../presentation/pages/search_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/auth_pages/sign_in_page.dart';
import '../../presentation/pages/auth_pages/sign_up_page.dart';
import '../../presentation/pages/task_pages/new_task_page.dart';
import '../../presentation/pages/task_pages/task_page.dart';
import '../../presentation/pages/task_pages/tasks_page.dart';
import '../model/project_model.dart';
import '../model/task_model.dart';

// TODO 99: manipulate views depending on user access level

FirebaseAuthService auth = FirebaseAuthService();

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: auth.user == null ? '/sign-in' : '/tasks', // as below
  initialPath: auth.user == null
      ? '/sign-in'
      : '/tasks', // check auth status and redirect to '/home' or '/login'
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/resources': (context, state, data) {
        return const BeamPage(
          key: ValueKey('resources'),
          type: BeamPageType.noTransition,
          title: 'Project Planner',
          child: ResourcesPage(),
        );
      },
      '/sign-in': (context, state, data) {
        return const BeamPage(
          key: ValueKey('sign-in'),
          type: BeamPageType.noTransition,
          title: 'Sign In',
          child: SignInPage(),
        );
      },
      '/sign-up': (context, state, data) {
        return const BeamPage(
          key: ValueKey('sign-up'),
          type: BeamPageType.noTransition,
          title: 'Sign Up',
          child: SignUpPage(),
        );
      },
      '/forgot-password': (context, state, data) {
        return const BeamPage(
          key: ValueKey('forgot-password'),
          type: BeamPageType.noTransition,
          title: 'Forgot Password',
          child: ForgotPasswordPage(),
        );
      },
      '/register-company': (context, state, data) {
        return const BeamPage(
          key: ValueKey('register-company'),
          type: BeamPageType.noTransition,
          title: 'Company Registration',
          child: CompanyRegistrationPage(),
        );
      },
      '/join-company': (context, state, data) {
        return const BeamPage(
          key: ValueKey('join-company'),
          type: BeamPageType.noTransition,
          title: 'Join a Company',
          child: JoinCompanyPage(),
        );
      },
      '/tasks': (context, state, data) {
        return const BeamPage(
          key: ValueKey('tasks'),
          type: BeamPageType.noTransition,
          title: 'Tasks',
          //'$data.taskHeading',
          child: TasksPage(),
          //TaskPage(task: data as Task, taskID: data.taskID),
        );
      },
      '/new-task': (context, state, data) {
        return const BeamPage(
          key: ValueKey('new-task'),
          type: BeamPageType.noTransition,
          title: 'New Task',
          child: NewTaskPage(),
        );
      },
      '/task-page': (context, state, data) {
        return BeamPage(
          key: const ValueKey('task-page'),
          type: BeamPageType.noTransition,
          title: '$data.taskHeading',
          child: TaskPage(task: data as Task, taskID: data.taskID),
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
      '/new-project': (context, state, data) {
        return const BeamPage(
          key: ValueKey('new-project'),
          type: BeamPageType.noTransition,
          title: 'New Project',
          child: NewProjectPage(),
        );
      },
      '/project-page': (context, state, data) {
        return BeamPage(
          key: const ValueKey('project-page'),
          type: BeamPageType.noTransition,
          title: '$data.projectTitle',
          child:
              ProjectPage(project: data as Project, projectID: data.projectID),
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
      '/plans-page': (context, state, data) {
        return BeamPage(
          key: const ValueKey('plans-page'),
          type: BeamPageType.noTransition,
          title: '$data.projectTitle',
          child: PlansPage(project: data as Project, projectID: data.projectID),
        );
      },
      '/proposals-page': (context, state, data) {
        return BeamPage(
          key: const ValueKey('proposals-page'),
          type: BeamPageType.noTransition,
          title: '$data.projectTitle',
          child: ProposalsPage(
              project: data as Project, projectID: data.projectID),
        );
      },
      '/management-page': (context, state, data) {
        return BeamPage(
          key: const ValueKey('management-page'),
          type: BeamPageType.noTransition,
          title: '$data.projectTitle',
          child: ManagementPage(
              project: data as Project, projectID: data.projectID),
        );
      },
      '/schedule-page': (context, state, data) {
        return BeamPage(
          key: const ValueKey('schedule-page'),
          type: BeamPageType.noTransition,
          title: '$data.projectTitle',
          child:
              SchedulePage(project: data as Project, projectID: data.projectID),
        );
      },
    },
  ).call,
);
