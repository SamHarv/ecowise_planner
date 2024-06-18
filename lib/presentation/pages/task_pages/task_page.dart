import 'package:ecowise_planner/domain/model/task_model.dart';
import 'package:ecowise_planner/domain/model/user_model.dart';
import 'package:ecowise_planner/presentation/widgets/borderless_dropdown_menu_widget.dart';
import 'package:ecowise_planner/presentation/widgets/borderless_field_widget.dart';
import 'package:ecowise_planner/presentation/widgets/custom_dialog_widget.dart';
import 'package:ecowise_planner/presentation/widgets/custom_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '/domain/utils/constants.dart';

import '../../state_management/providers.dart';

import '../../../domain/model/project_model.dart';

// TODO 99: Add budget implementation? Check with Darc

enum CostType { labour, material }

class TaskPage extends ConsumerStatefulWidget {
  final Task task;
  final String taskID;

  const TaskPage({
    super.key,
    required this.task,
    required this.taskID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  final tempMap = {
    'Now': [
      'Task 1',
      'Task 2',
      'Task 3',
      'Task 4',
      'Task 5',
      'Task 6',
    ],
    'Coming Up': [
      'Task 7',
      'Task 8',
      'Task 9',
      'Task 10',
      'Task 11',
      'Task 12',
    ],
    'Future': [
      'Task 13',
      'Task 14',
      'Task 15',
      'Task 16',
      'Task 17',
      'Task 18',
    ],
  };
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  double calculateLabourCosts() {
    double labourCosts = 0;
    widget.task.labourCosts.forEach((key, value) {
      labourCosts += value;
    });
    return labourCosts;
  }

  double calculateMaterialCosts() {
    double materialCosts = 0;
    widget.task.materialCosts.forEach((key, value) {
      materialCosts += value;
    });
    return materialCosts;
  }

  double calculateTotalCosts() {
    double totalCosts = 0;
    widget.task.labourCosts.forEach((key, value) {
      totalCosts += value;
    });
    widget.task.materialCosts.forEach((key, value) {
      totalCosts += value;
    });
    return totalCosts;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headingController =
        TextEditingController(text: widget.task.taskHeading);
    headingController.selection = TextSelection.fromPosition(
      TextPosition(offset: headingController.text.length),
    );

    final taskNotesController = TextEditingController(text: widget.task.notes);
    taskNotesController.selection = TextSelection.fromPosition(
        TextPosition(offset: taskNotesController.text.length));
    final labourCostController = TextEditingController();
    final materialCostController = TextEditingController();
    final labourCostDescController = TextEditingController();
    final materialCostDescController = TextEditingController();
    // String status = widget.project.projectStatus;
    // String dueDate = widget.project.projectDueDate;
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    final validate = ref.read(validation);

    Future<Project> getProject() async {
      final companyID = await db.getCompanyID(userID: auth.user!.uid);
      final project = await db.getProject(
          projectID: widget.task.projectID, companyID: companyID);
      return project;
    }

    Future<List<dynamic>> getUsers() async {
      final user = await db.getUser(userID: auth.user!.uid);
      final users = await db.getUsers(companyID: user.companyID);
      return users;
    }

    String statusSwitch(String status) {
      switch (status) {
        case "for-action":
          return "For Action";
        case "in-progress":
          return "In Progress";
        case "waiting":
          return "Waiting";
        case "completed":
          return "Completed";
        case "backlog":
          return "Backlog";
        default:
          return "For Action";
      }
    }

    Future<List<String>> getNames(List<dynamic> employees) async {
      final names = <String>[];
      for (var employee in employees) {
        UserModel user = await db.getUser(userID: employee);
        names.add("${user.firstName} ${user.surname}");
      }
      return names;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Task View"),
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            );

            try {
              if (validate.validateTitle(headingController.text.trim()) !=
                  null) {
                throw "Heading is required";
              }
            } catch (e) {
              showMessage(e.toString());
            }

            try {
              // Create Task object
              final task = Task(
                taskID: widget.task.taskID,
                projectID: widget.task.projectID,
                taskHeading: headingController.text.trim(),
                taskSchedule: widget.task.taskSchedule,
                taskStatus: widget.task.taskStatus,
                taskCreatedDate: widget.task.taskCreatedDate,
                taskDueDate: widget.task.taskDueDate,
                notes: taskNotesController.text.trim(),
                labourCosts: widget.task.labourCosts,
                materialCosts: widget.task.materialCosts,
                totalCosts: calculateTotalCosts(),
                assignedTo: widget.task.assignedTo,
                assignedBy: widget.task.assignedBy,
              );

              // Save to Firestore
              await db.updateTask(task: task, userID: auth.user!.uid);

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              showMessage("Task updated!");
              // ignore: use_build_context_synchronously
              Beamer.of(context).beamToNamed('/tasks');
            } catch (e) {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              showMessage(e.toString());
            }
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: mediaWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: BorderlessFieldWidget(
                    width: mediaWidth * 0.9,
                    controller: headingController,
                    hintText: "Project Title",
                    fontSize: 20,
                    onChanged: (text) {
                      widget.task.taskHeading = text;
                    },
                  ),
                ),
                gapH20,
                FutureBuilder(
                  future: getProject(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('An error occurred! ${snapshot.error}'),
                      );
                    }
                    final project = snapshot.data;
                    final projectTitle = project!.projectTitle;
                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: mediaWidth * 0.9 - 32,
                          child: Text(
                            projectTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Beamer.of(context).beamToNamed(
                          '/project-page',
                          data: project,
                        );
                      },
                    );
                  },
                ),
                gapH20,
                FutureBuilder(
                    future: getUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('An error occurred! ${snapshot.error}'),
                        );
                      }
                      final users = snapshot.data!;
                      if (users.isEmpty) {
                        return const Center(
                          child: Text('No Users Found!'),
                        );
                      }
                      return FutureBuilder(
                          future: getNames(widget.task.assignedTo!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    'An error occurred! ${snapshot.error}'),
                              );
                            }
                            final assignedTo = snapshot.data!;
                            if (assignedTo.isEmpty) {
                              return const Center(
                                child: Text('No Users Assigned!'),
                              );
                            }
                            return BorderlessDropdownMenuWidget(
                              hintText: widget.task.assignedTo == []
                                  ? "Assigned To:"
                                  : "Assigned To: ${assignedTo.toString()}",
                              dropdownMenuEntries: users
                                  .map(
                                    (user) => DropdownMenuEntry(
                                      value: user,
                                      label:
                                          "${user.firstName} ${user.surname}",
                                    ),
                                  )
                                  .toList(),
                              onSelected: (employee) {
                                if (employee != null &&
                                    !widget.task.assignedTo!
                                        .contains(employee.userID)) {
                                  setState(() {
                                    widget.task.assignedTo!
                                        .add(employee.userID);
                                  });
                                }
                              },
                              width: mediaWidth * 0.9 - 32,
                              label: "Assigned To",
                            );
                          });
                    }),
                gapH20,
                SizedBox(
                  width: mediaWidth * 0.9 - 32,
                  child: Text(
                    "Assigned By: ${widget.task.assignedBy}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                gapH20,
                // Task Schedule
                BorderlessDropdownMenuWidget(
                  hintText: widget.task.taskSchedule == "pre-task"
                      ? "Preparation Task"
                      : "Action Task",
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(
                        value: "pre-task", label: "Preparation Task"),
                    DropdownMenuEntry(
                        value: "action-task", label: "Action Task"),
                  ],
                  onSelected: (schedule) {
                    if (schedule != null) {
                      // setState(() {
                      widget.task.taskSchedule = schedule;
                      // });
                    }
                  },
                  width: mediaWidth * 0.9 - 32,
                  label: "Schedule",
                ),
                gapH20,
                BorderlessDropdownMenuWidget(
                  hintText: statusSwitch(widget.task.taskStatus),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "for-action", label: "For Action"),
                    DropdownMenuEntry(
                        value: "in-progress", label: "In Progress"),
                    DropdownMenuEntry(value: "waiting", label: "Waiting"),
                    DropdownMenuEntry(value: "completed", label: "Completed"),
                    DropdownMenuEntry(value: "backlog", label: "Backlog")
                  ],
                  onSelected: (status) {
                    if (status != null) {
                      // setState(() {
                      widget.task.taskStatus = status;
                      // });
                    }
                  },
                  width: mediaWidth * 0.9 - 32,
                  label: "Task Status",
                ),
                gapH20,
                SizedBox(
                  width: mediaWidth * 0.9 - 32,
                  child: Text(
                    "Created: ${DateTime.parse(widget.task.taskCreatedDate).day}-${DateTime.parse(widget.task.taskCreatedDate).month}-${DateTime.parse(widget.task.taskCreatedDate).year}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: mediaWidth * 0.9 - 32,
                  child: Row(
                    children: [
                      Text(
                        "Due Date: ${DateTime.parse(widget.task.taskDueDate).day}-${DateTime.parse(widget.task.taskDueDate).month}-${DateTime.parse(widget.task.taskDueDate).year}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              String newDate = "";
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Center(
                                    child: CustomDialogWidget(
                                      dialogHeading: "Select Due Date",
                                      dialogContent: SizedBox(
                                        width: mediaWidth * 0.9,
                                        child: CalendarDatePicker(
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100, 12, 31),
                                          onDateChanged: (date) {
                                            setState(() {
                                              newDate = date.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      dialogActions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // setState(() {
                                            widget.task.taskDueDate = newDate;
                                            // });
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
                gapH20,
                Container(
                  // height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BorderlessFieldWidget(
                      inputType: TextInputType.multiline,
                      maxLines: 200,
                      minLines: 3,
                      width: mediaWidth * 0.9 - 32,
                      controller: taskNotesController,
                      hintText: "Notes",
                      fontSize: 16,
                      onChanged: (text) {
                        widget.task.notes = text;
                      },
                    ),
                  ),
                ),
                gapH20,
                SizedBox(
                  width: mediaWidth * 0.9 - 32,
                  child: const Text(
                    "Sub Tasks",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                gapH20,
                // // TODO 11: implement sub tasks here properly
                Container(
                  width: mediaWidth * 0.9,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListView(
                    children: [
                      for (int index = 0; index < tempMap.length; index++)
                        ExpansionTile(
                          initiallyExpanded: true,
                          shape: index == 0
                              ? const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                )
                              : null,
                          collapsedShape: index == 0
                              ? const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                )
                              : null,
                          title: Text(
                            tempMap.keys.elementAt(index),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          children: tempMap.values
                              .elementAt(index)
                              .map((e) => ListTile(title: Text(e)))
                              .toList(),
                        ),
                    ],
                  ),
                ),
                gapH20,
                SizedBox(
                  width: mediaWidth * 0.9 - 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Labour Costs: \$${calculateLabourCosts()}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Material Costs: \$${calculateMaterialCosts()}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Total Costs: \$${calculateTotalCosts()}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      FloatingActionButton(
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Costs",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              var selected = {CostType.labour};
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Center(
                                    child: CustomDialogWidget(
                                      dialogHeading: "Add Costs",
                                      dialogContent: SizedBox(
                                        width: mediaWidth * 0.9,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SegmentedButton(
                                              segments: const [
                                                ButtonSegment(
                                                  value: CostType.labour,
                                                  label: Text("Labour"),
                                                ),
                                                ButtonSegment(
                                                  value: CostType.material,
                                                  label: Text("Material"),
                                                ),
                                              ],
                                              selected: selected,
                                              onSelectionChanged:
                                                  (Set<CostType> newSelection) {
                                                setState(() {
                                                  selected = newSelection;
                                                });
                                                setState(() {});
                                              },
                                            ),
                                            gapH20,
                                            CustomFieldWidget(
                                              textController: selected
                                                          .toString() ==
                                                      {CostType.labour}
                                                          .toString()
                                                  ? labourCostDescController
                                                  : materialCostDescController,
                                              hintText: "Description",
                                              textCapitalization:
                                                  TextCapitalization.none,
                                              width: mediaWidth * 0.8,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 20,
                                            ),
                                            gapH20,
                                            CustomFieldWidget(
                                              textController:
                                                  selected.toString() ==
                                                          {CostType.labour}
                                                              .toString()
                                                      ? labourCostController
                                                      : materialCostController,
                                              hintText: "Amount (\$)",
                                              textCapitalization:
                                                  TextCapitalization.none,
                                              width: mediaWidth * 0.8,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ],
                                        ),
                                      ),
                                      dialogActions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              if (selected.toString() ==
                                                  {CostType.labour}
                                                      .toString()) {
                                                widget.task.labourCosts[
                                                    labourCostDescController
                                                        .text] = double.parse(
                                                    labourCostController.text);
                                              } else if (selected.toString() ==
                                                  {CostType.material}
                                                      .toString()) {
                                                widget.task.materialCosts[
                                                    materialCostDescController
                                                        .text] = double.parse(
                                                    materialCostController
                                                        .text);
                                              }
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                // // TODO 11: Work out the best way to view and interact with costs
                gapH20,
                Divider(
                  indent: mediaWidth * 0.05,
                  endIndent: mediaWidth * 0.05,
                ),
                gapH20,
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: const Text(
                            "Delete Task",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            "Are you sure you want to delete this task?",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await db.deleteTask(
                                  taskID: widget.task.taskID,
                                  projectID: widget.task.projectID,
                                  userID: auth.user!.uid,
                                );
                                // ignore: use_build_context_synchronously
                                Beamer.of(context).beamToNamed('/tasks');
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Delete Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                gapH20,
              ],
            ),
          ),
        ),
      ),
    );
    // no bottom nav bar, just back button up top
  }
}
