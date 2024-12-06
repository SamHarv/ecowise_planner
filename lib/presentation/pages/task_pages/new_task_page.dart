import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/domain/model/task_model.dart';
import 'package:ecowise_planner/domain/utils/constants.dart';
import 'package:ecowise_planner/presentation/widgets/custom_dropdown_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/model/project_model.dart';
import '../../state_management/providers.dart';
import '../../widgets/borderless_field_widget.dart';
import '../../widgets/custom_dialog_widget.dart';
import '../../widgets/custom_field_widget.dart';

class NewTaskPage extends ConsumerStatefulWidget {
  const NewTaskPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends ConsumerState<NewTaskPage> {
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
  double calculateLabourCosts(Project project) {
    double labourCosts = 0;
    project.labourCosts.forEach((key, value) {
      labourCosts += value;
    });
    return labourCosts;
  }

  double calculateMaterialCosts(Project project) {
    double materialCosts = 0;
    project.materialCosts.forEach((key, value) {
      materialCosts += value;
    });
    return materialCosts;
  }

  double calculateTotalCosts(Project project) {
    double totalCosts = 0;
    project.labourCosts.forEach((key, value) {
      totalCosts += value;
    });
    project.materialCosts.forEach((key, value) {
      totalCosts += value;
    });
    return totalCosts;
  }

  late String projectID;
  final _headingController = TextEditingController();
  final _notesController = TextEditingController();
  String _schedule = "";
  List<dynamic> assignedTo = [];
  String _status = "";
  String _dueDate = DateTime.now().toString();

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

  @override
  void dispose() {
    _headingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    final validate = ref.read(validation);

    Future<List<dynamic>> getUsers() async {
      final user = await db.getUser(userID: auth.user!.uid);
      final users = await db.getUsers(companyID: user.companyID);
      return users;
    }

    Future<List<dynamic>> getProjects() async {
      final projects = await db.getProjects(userID: auth.user!.uid);
      // sort projects by due date
      projects.sort((a, b) => a.projectDueDate.compareTo(b.projectDueDate));
      return projects;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Task"),
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogWidget(
                    dialogHeading: "Exit Without Saving?",
                    dialogActions: [
                      TextButton(
                        onPressed: () {
                          Beamer.of(context).beamBack();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              gapH20,
              const Text("Task Information", style: TextStyle(fontSize: 20)),
              gapH20,
              CustomFieldWidget(
                textController: _headingController,
                hintText: "Task Heading",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.text,
              ),
              gapH20,
              FutureBuilder(
                future: getProjects(),
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
                  final projects = snapshot.data!;
                  if (projects.isEmpty) {
                    return const Center(
                      child: Text('No Projects Found!'),
                    );
                  }
                  return CustomDropdownMenuWidget(
                    dropdownMenuEntries: projects.map((project) {
                      return DropdownMenuEntry(
                        value: project.projectID,
                        label: project.projectTitle,
                      );
                    }).toList(),
                    onSelected: (option) {
                      if (option != null) {
                        // setState(() {
                        projectID = option;
                        // });
                      }
                    },
                    width: mediaWidth * 0.9,
                    label: "Project",
                  );
                },
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
                    controller: _notesController,
                    hintText: "Notes",
                    fontSize: 16,
                    // Below not required for initial creation of task
                    // onChanged: (text) {
                    //   widget.project.projectNotes = text;
                    // },
                  ),
                ),
              ),
              gapH20,
              CustomDropdownMenuWidget(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                      value: "pre-task", label: "Preparation Task"),
                  DropdownMenuEntry(value: "action-task", label: "Action Task"),
                ],
                onSelected: (schedule) {
                  if (schedule != null) {
                    // setState(() {
                    _schedule = schedule;
                    // });
                  }
                },
                width: mediaWidth * 0.9,
                label: "Schedule",
              ),
              gapH20,
              CustomDropdownMenuWidget(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "for-action", label: "For Action"),
                  DropdownMenuEntry(value: "in-progress", label: "In Progress"),
                  DropdownMenuEntry(value: "waiting", label: "Waiting"),
                  DropdownMenuEntry(value: "completed", label: "Completed"),
                  DropdownMenuEntry(value: "backlog", label: "Backlog")
                ],
                onSelected: (status) {
                  if (status != null) {
                    // setState(() {
                    _status = status;
                    // });
                  }
                },
                width: mediaWidth * 0.9,
                label: "Task Status",
              ),

              gapH20,
              SizedBox(
                width: mediaWidth * 0.9,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Due Date",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              gapH20,
              // Calendar widget for due date
              SizedBox(
                width: mediaWidth * 0.9,
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100, 12, 31),
                  onDateChanged: (date) {
                    // setState(() {
                    _dueDate = date.toString();
                    // });
                  },
                ),
              ),
              gapH20,
              // TODO 99: Assigned to
              //  Multi-select dropdown for assigning task to multiple users
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
                  return CustomDropdownMenuWidget(
                    dropdownMenuEntries: users.map((user) {
                      return DropdownMenuEntry(
                        value: user.userID,
                        label: "${user.firstName} ${user.surname}",
                      );
                    }).toList(),
                    onSelected: (user) {
                      if (user != null) {
                        // setState(() {
                        assignedTo.add(user);
                        // });
                      }
                    },
                    width: mediaWidth * 0.9,
                    label: "Assigned To:",
                  );
                },
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
              // TODO 00: Implement sub tasks properly
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
                width: mediaWidth * 0.9,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
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

                    // Validate inputs
                    try {
                      if (validate
                              .validateTitle(_headingController.text.trim()) !=
                          null) {
                        throw "Heading is required";
                      }
                    } catch (e) {
                      showMessage(e.toString());
                    }

                    try {
                      const uuid = Uuid();
                      String taskId = uuid.v4();

                      final user = await db.getUser(userID: auth.user!.uid);

                      // Create Task object
                      final task = Task(
                        projectID: projectID,
                        taskHeading: _headingController.text.trim(),
                        notes: _notesController.text.trim(),
                        taskID: taskId,
                        taskSchedule: _schedule,
                        taskStatus: _status,
                        taskDueDate: _dueDate,
                        taskCreatedDate: DateTime.now().toString(),
                        subTasks: [],
                        assignedTo: assignedTo,
                        assignedBy: "${user.firstName} ${user.surname}",
                        labourCosts: {},
                        materialCosts: {},
                        totalCosts: 0,
                      );

                      String userID = auth.user!.uid;

                      // Update project with new task
                      String companyID = await db.getCompanyID(userID: userID);
                      Project project = await db.getProject(
                          companyID: companyID, projectID: projectID);
                      project.tasks.add(taskId);
                      await db.updateProject(project: project);

                      // Save to Firestore
                      await db.addTask(task: task, userID: userID);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showMessage("Project added!");
                      // ignore: use_build_context_synchronously
                      Beamer.of(context).beamToNamed('/projects');
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showMessage(e.toString());
                    }
                  },
                  child: const Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              gapH20,
            ],
          ),
        ),
      ),
    );
    // no bottom nav bar, just back button up top
  }
}
