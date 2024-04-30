import 'user_model.dart';

class Task {
  final String taskID;
  final String taskHeading;
  final String taskDescription;
  final String projectID;
  final String taskSchedule; // Pre-task or task
  final String taskStatus; // for action, in progress, awaiting, complete
  final String taskDueDate;
  final String taskCreatedDate;
  final List<Task>? subTasks;
  final List<User>? assignedTo;
  final Map<String, double>?
      labourCosts; // need to be able to generate to spreadsheet
  final Map<String, double>? materialCosts;
  final double totalCosts;
  // attachments ??

  Task({
    required this.taskID,
    required this.taskHeading,
    required this.taskDescription,
    required this.projectID,
    required this.taskSchedule,
    required this.taskStatus,
    required this.taskDueDate,
    required this.taskCreatedDate,
    this.subTasks,
    this.assignedTo,
    this.labourCosts,
    this.materialCosts,
    required this.totalCosts,
  });
}
