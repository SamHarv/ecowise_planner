import 'task_model.dart';

class Project {
  final String projectID;
  final String companyID;
  String projectTitle;
  String projectDescription; // Hybrid home, etc.
  String projectAddress1;
  String projectCity;
  String projectState;
  String projectPostCode;
  String projectStatus;
  String projectDueDate;
  final String projectCreatedDate;
  String primaryClientName;
  String primaryClientEmail;
  String primaryClientPhone;
  String? secondaryClientName;
  String? secondaryClientEmail;
  String? secondaryClientPhone;
  String? projectNotes;
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
