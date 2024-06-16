class Task {
  final String taskID;
  final String taskHeading;
  final String? notes;
  final String projectID;
  final String taskSchedule; // Pre-task or task
  final String taskStatus; // for action, in progress, awaiting, complete
  final String taskDueDate;
  final String taskCreatedDate;
  final List<dynamic>? subTasks;
  final List<dynamic>? assignedTo;
  final Map<String, dynamic>
      labourCosts; // need to be able to generate to spreadsheet
  final Map<String, dynamic> materialCosts;
  final double totalCosts;
  // attachments ??

  Task({
    required this.taskID,
    required this.taskHeading,
    required this.notes,
    required this.projectID,
    required this.taskSchedule,
    required this.taskStatus,
    required this.taskDueDate,
    required this.taskCreatedDate,
    this.subTasks,
    this.assignedTo,
    this.labourCosts = const {},
    this.materialCosts = const {},
    required this.totalCosts,
  });
}
