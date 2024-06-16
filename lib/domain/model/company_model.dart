import 'package:firebase_auth/firebase_auth.dart';

class Company {
  final String companyID;
  final String name;
  final List<User> employees;
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
