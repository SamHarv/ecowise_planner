import 'project_model.dart';

import 'user_model.dart';

class Company {
  final String companyID;
  final String name;
  final List<dynamic> employees;
  final List<dynamic> projects;

  Company({
    required this.companyID,
    required this.name,
    this.employees = const [],
    this.projects = const [],
  });

  @override
  String toString() {
    return 'Company{companyID: $companyID, name: $name, employees: $employees, projects: $projects}';
  }
}
