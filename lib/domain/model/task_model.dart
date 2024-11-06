class Task {
  final String taskID;
  String taskHeading;
  String? notes;
  final String projectID;
  String taskSchedule; // Pre-task or task
  String taskStatus; // for action, in progress, awaiting, complete
  String taskDueDate;
  final String taskCreatedDate;
  final List<dynamic>? subTasks;
  List<dynamic>? assignedTo;
  String assignedBy;
  final Map<String, dynamic>
      labourCosts; // need to be able to generate to spreadsheet
  final Map<String, dynamic> materialCosts;
  final num totalCosts;
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
    this.assignedTo = const [],
    required this.assignedBy,
    this.labourCosts = const {},
    this.materialCosts = const {},
    required this.totalCosts,
  });
}
