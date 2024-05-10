import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/domain/model/project_model.dart';
import 'package:ecowise_planner/domain/utils/constants.dart';
import 'package:ecowise_planner/presentation/widgets/custom_dropdown_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../state_management/providers.dart';
import '../../widgets/custom_field_widget.dart';

class NewProjectPage extends ConsumerStatefulWidget {
  const NewProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends ConsumerState<NewProjectPage> {
  final _titleController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _primaryClientNameController = TextEditingController();
  final _primaryClientEmailController = TextEditingController();
  final _primaryClientPhoneController = TextEditingController();
  final _secondaryClientNameController = TextEditingController();
  final _secondaryClientEmailController = TextEditingController();
  final _secondaryClientPhoneController = TextEditingController();
  String _geoState = "";
  String _reference = "";
  String _status = "";
  String _dueDate = "";

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
    _titleController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    _primaryClientNameController.dispose();
    _primaryClientEmailController.dispose();
    _primaryClientPhoneController.dispose();
    _secondaryClientNameController.dispose();
    _secondaryClientEmailController.dispose();
    _secondaryClientPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    final validate = ref.read(validation);
    // generate projectID with UUID
    // get companyID from user
    // Create projectTitle, projectDescription, projectDueDate, projectStatus,
    // projectCreatedDate
    // Create and add clients
    // Add any project notes
    // Add tasks
    // Set labourCosts, materialCosts to empty list
    // Set totalCosts to 0.0
    // Create object with above data and save to Firestore for display on Projects page
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Project"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // ask whether they would like to save the project
            Beamer.of(context).beamToNamed('/projects');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              gapH20,
              const Text("Project Information", style: TextStyle(fontSize: 20)),
              gapH20,
              CustomFieldWidget(
                textController: _titleController,
                hintText: "Project Title",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.text,
              ),
              gapH20,
              CustomFieldWidget(
                textController: _streetAddressController,
                hintText: "Street Adress",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.text,
              ),
              gapH20,
              SizedBox(
                width: mediaWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomFieldWidget(
                      textController: _cityController,
                      hintText: "City",
                      textCapitalization: TextCapitalization.words,
                      width: mediaWidth * 0.43,
                      keyboardType: TextInputType.text,
                    ),
                    // gapW20,
                    CustomDropdownMenuWidget(
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: "VIC", label: "VIC"),
                        DropdownMenuEntry(value: "NSW", label: "NSW"),
                        DropdownMenuEntry(value: "QLD", label: "QLD"),
                        DropdownMenuEntry(value: "SA", label: "SA"),
                        DropdownMenuEntry(value: "WA", label: "WA"),
                        DropdownMenuEntry(value: "TAS", label: "TAS"),
                        DropdownMenuEntry(value: "NT", label: "NT"),
                        DropdownMenuEntry(value: "ACT", label: "ACT"),
                      ],
                      onSelected: (state) {
                        if (state != null) {
                          setState(() {
                            _geoState = state;
                          });
                        }
                      },
                      width: mediaWidth * 0.43,
                      label: "State",
                    ),
                  ],
                ),
              ),
              gapH20,
              SizedBox(
                width: mediaWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomFieldWidget(
                      textController: _postcodeController,
                      hintText: "Postcode",
                      textCapitalization: TextCapitalization.words,
                      width: mediaWidth * 0.43,
                      keyboardType: TextInputType.number,
                    ),
                    // gapW20,
                    CustomDropdownMenuWidget(
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                            value: "Australia", label: "Australia"),
                      ],
                      onSelected: (country) {
                        if (country != null) {
                          setState(() {
                            // _country = country;
                          });
                        }
                      },
                      width: mediaWidth * 0.43,
                      label: "Country",
                    ),
                  ],
                ),
              ),
              gapH20,
              CustomDropdownMenuWidget(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "Hybrid Home", label: "Hybrid Home"),
                  DropdownMenuEntry(value: "New Home", label: "New Home"),
                ],
                onSelected: (reference) {
                  if (reference != null) {
                    setState(() {
                      _reference = reference;
                    });
                  }
                },
                width: mediaWidth * 0.9,
                label: "Reference",
              ),
              gapH20,
              CustomDropdownMenuWidget(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "Backlog", label: "Backlog"),
                  DropdownMenuEntry(value: "Pending", label: "Pending"),
                  DropdownMenuEntry(value: "In Progress", label: "In Progress"),
                  DropdownMenuEntry(value: "Completed", label: "Completed"),
                  DropdownMenuEntry(value: "Cancelled", label: "Cancelled"),
                ],
                onSelected: (status) {
                  if (status != null) {
                    setState(() {
                      _status = status;
                    });
                  }
                },
                width: mediaWidth * 0.9,
                label: "Status",
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
                    setState(() {
                      _dueDate = date.toString();
                    });
                  },
                ),
              ),
              gapH20,
              const Text("Contact Information", style: TextStyle(fontSize: 20)),
              gapH20,
              SizedBox(
                width: mediaWidth * 0.9,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Primary Contact",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              gapH20,
              CustomFieldWidget(
                textController: _primaryClientNameController,
                hintText: "Contact Name",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.text,
              ),
              gapH20,
              CustomFieldWidget(
                textController: _primaryClientEmailController,
                hintText: "Contact Email Address",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.emailAddress,
              ),
              gapH20,
              CustomFieldWidget(
                textController: _primaryClientPhoneController,
                hintText: "Contact Phone Number",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.phone,
              ),
              gapH20,
              SizedBox(
                width: mediaWidth * 0.9,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Secondary Contact (Optional)",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              gapH20,
              CustomFieldWidget(
                textController: _secondaryClientNameController,
                hintText: "Contact Name",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.text,
              ),
              gapH20,
              CustomFieldWidget(
                textController: _secondaryClientEmailController,
                hintText: "Contact Email Address",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.emailAddress,
              ),
              gapH20,
              CustomFieldWidget(
                textController: _secondaryClientPhoneController,
                hintText: "Contact Phone Number",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.phone,
              ),
              gapH20,
              SizedBox(
                width: mediaWidth * 0.9,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
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

                    // TODO 00: Change below to logic to create client/s and project
                    // then beam back to projects page

                    // Validate inputs
                    try {
                      if (validate
                              .validateTitle(_titleController.text.trim()) !=
                          null) {
                        throw "Title is required";
                      }
                      if (validate.validateStreetAddress(
                              _streetAddressController.text.trim()) !=
                          null) {
                        throw "Street Address is required";
                      }
                      if (validate.validateCity(_cityController.text.trim()) !=
                          null) {
                        throw "City is required";
                      }
                      if (validate.validatePostcode(
                              _postcodeController.text.trim()) !=
                          null) {
                        throw "Postcode is required";
                      }
                      if (validate.validatePrimaryContactName(
                              _primaryClientNameController.text.trim()) !=
                          null) {
                        throw "Primary Contact Name is required";
                      }
                      if (validate.validateEmail(
                              _primaryClientEmailController.text.trim()) !=
                          null) {
                        throw "Primary Contact Email is required";
                      }
                      if (validate.validatePhone(
                              _primaryClientPhoneController.text.trim()) !=
                          null) {
                        throw "Primary Contact Phone is required";
                      }
                    } catch (e) {
                      showMessage(e.toString());
                    }

                    // Create Client objects
                    try {
                      const uuid = Uuid();
                      String projectId = uuid.v4();
                      final currentUser =
                          await db.getUser(userID: auth.user!.uid);

                      // Create Project object
                      final project = Project(
                        projectID: projectId,
                        companyID: currentUser.companyID,
                        projectTitle: _titleController.text.trim(),
                        projectDescription: _reference,
                        projectAddress1: _streetAddressController.text.trim(),
                        projectCity: _cityController.text.trim(),
                        projectState: _geoState,
                        projectPostCode: _postcodeController.text.trim(),
                        projectStatus: _status,
                        projectDueDate: _dueDate,
                        projectCreatedDate: DateTime.now().toString(),
                        primaryClientName:
                            _primaryClientNameController.text.trim(),
                        primaryClientEmail:
                            _primaryClientEmailController.text.trim(),
                        primaryClientPhone:
                            _primaryClientPhoneController.text.trim(),
                        secondaryClientName:
                            _secondaryClientNameController.text.trim(),
                        secondaryClientEmail:
                            _secondaryClientEmailController.text.trim(),
                        secondaryClientPhone:
                            _secondaryClientPhoneController.text.trim(),
                        projectNotes: [],
                        tasks: [],
                        labourCosts: {},
                        materialCosts: {},
                        totalCosts: 0.0,
                      );

                      // Save to Firestore
                      await db.addProject(project: project);
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
                    'Add Project',
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
