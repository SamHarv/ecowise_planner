import 'project_model.dart';

import 'user_model.dart';

class Company {
  final String companyID;
  final String name;
  final List<UserModel>? employees;
  final List<Project>? projects;

  Company({
    required this.companyID,
    required this.name,
    this.employees,
    this.projects,
  });

  @override
  String toString() {
    return 'Company{companyID: $companyID, name: $name, employees: $employees, projects: $projects}';
  }

  // TODO: Get employees - every user with companyID
}
