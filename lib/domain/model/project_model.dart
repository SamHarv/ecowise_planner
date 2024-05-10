import 'task_model.dart';

class Project {
  final String projectID;
  final String companyID;
  final String projectTitle;
  final String projectDescription; // Hybrid home, etc.
  final String projectAddress1;
  final String projectCity;
  final String projectState;
  final String projectPostCode;
  final String projectStatus;
  final String projectDueDate;
  final String projectCreatedDate;
  final String primaryClientName;
  final String primaryClientEmail;
  final String primaryClientPhone;
  final String? secondaryClientName;
  final String? secondaryClientEmail;
  final String? secondaryClientPhone;
  final List<String>? projectNotes;
  final List<Task>? tasks;
  final Map<String, double>? labourCosts;
  final Map<String, double>? materialCosts;
  final double totalCosts;
  // attachments ??
  // Quotes & Invoices??

  Project({
    required this.projectID,
    required this.companyID,
    required this.projectTitle,
    required this.projectDescription,
    required this.projectAddress1,
    required this.projectCity,
    required this.projectState,
    required this.projectPostCode,
    required this.projectStatus,
    required this.projectDueDate,
    required this.projectCreatedDate,
    required this.primaryClientName,
    required this.primaryClientEmail,
    required this.primaryClientPhone,
    this.secondaryClientName,
    this.secondaryClientEmail,
    this.secondaryClientPhone,
    this.projectNotes,
    this.tasks,
    this.labourCosts,
    this.materialCosts,
    required this.totalCosts,
  });
}
