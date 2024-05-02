import 'task_model.dart';

class Project {
  final String projectID;
  final String companyID;
  final String projectTitle;
  final String projectDescription;
  final String projectStatus;
  final String projectDueDate;
  final String projectCreatedDate;
  final String clientName;
  final List<Task>? tasks;
  final Map<String, double>? labourCosts;
  final Map<String, double>? materialCosts;
  final double totalCosts;
  // attachments ??

  Project({
    required this.projectID,
    required this.companyID,
    required this.projectTitle,
    required this.projectDescription,
    required this.projectStatus,
    required this.projectDueDate,
    required this.projectCreatedDate,
    required this.clientName,
    this.tasks,
    this.labourCosts,
    this.materialCosts,
    required this.totalCosts,
  });
}
