import 'package:ecowise_planner/presentation/widgets/borderless_dropdown_menu_widget.dart';
import 'package:ecowise_planner/presentation/widgets/borderless_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';

import '/domain/utils/constants.dart';

import '../../state_management/providers.dart';
import '../../widgets/custom_field_widget.dart';

import '../../../domain/model/project_model.dart';

//TODO 00: implement this page
// Title
// Reference (desc)
// Address1 + city + state + postcode which you can navigate to with Maps
// Status
// Due date
// Created date
// Primary client name, email, phone
// Email the client
// Call the client
// Secondary client name, email, phone
// Take notes
// CRUD tasks
// See labour, material, and total costs if access
// See hours spent on project for employees if access
// Edit project and delete project buttons in app bar

// TODO 11: add edit project page/ enable editing from this page

class ProjectPage extends ConsumerStatefulWidget {
  final Project project;
  final String projectID;

  const ProjectPage({
    super.key,
    required this.project,
    required this.projectID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectPageState();
}

class _ProjectPageState extends ConsumerState<ProjectPage> {
  bool editingAddress = false;
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

  void launchMaps(String address) async {
    String encodedAddress = Uri.encodeFull(address);
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleController =
        TextEditingController(text: widget.project.projectTitle);
    final streetAddressController =
        TextEditingController(text: widget.project.projectAddress1);
    final cityController =
        TextEditingController(text: widget.project.projectCity);
    final postcodeController =
        TextEditingController(text: widget.project.projectPostCode);
    final primaryClientNameController = TextEditingController();
    final primaryClientEmailController = TextEditingController();
    final primaryClientPhoneController = TextEditingController();
    final secondaryClientNameController = TextEditingController();
    final secondaryClientEmailController = TextEditingController();
    final secondaryClientPhoneController = TextEditingController();
    String geoState = widget.project.projectState;
    String reference = widget.project.projectDescription;
    String status = widget.project.projectStatus;
    String dueDate = "";
    final mediaWidth = MediaQuery.of(context).size.width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    final validate = ref.read(validation);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project View"),
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
            Beamer.of(context).beamToNamed('/projects');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              gapH20,
              BorderlessFieldWidget(
                width: mediaWidth * 0.9,
                controller: titleController,
                hintText: "Project Title",
                fontSize: 20,
              ),
              !editingAddress
                  ? SizedBox(
                      width: mediaWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.project.projectAddress1}\n"
                            "${widget.project.projectCity}\n"
                            "${widget.project.projectState} "
                            "${widget.project.projectPostCode}\nAustralia",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      editingAddress = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    launchMaps(
                                        "${widget.project.projectAddress1}, "
                                        "${widget.project.projectCity}, "
                                        "${widget.project.projectState}, "
                                        "${widget.project.projectPostCode}"
                                        ", Australia");
                                  },
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          width: mediaWidth * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BorderlessFieldWidget(
                                width: mediaWidth * 0.43,
                                controller: streetAddressController,
                                hintText: "Street Address",
                                fontSize: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      editingAddress = false;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mediaWidth * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BorderlessFieldWidget(
                                width: mediaWidth * 0.43,
                                controller: cityController,
                                hintText: "City",
                                fontSize: 16,
                              ),
                              BorderlessDropdownMenuWidget(
                                hintText: geoState,
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
                                      geoState = state;
                                    });
                                  }
                                },
                                width: mediaWidth * 0.43,
                                label: "State",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mediaWidth * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BorderlessFieldWidget(
                                width: mediaWidth * 0.43,
                                controller: postcodeController,
                                hintText: "Postcode",
                                fontSize: 16,
                              ),
                              BorderlessDropdownMenuWidget(
                                hintText: "Australia",
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
                      ],
                    ),

              BorderlessDropdownMenuWidget(
                hintText: reference,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "Hybrid Home", label: "Hybrid Home"),
                  DropdownMenuEntry(value: "New Home", label: "New Home"),
                ],
                onSelected: (reference) {
                  if (reference != null) {
                    setState(() {
                      reference = reference;
                    });
                  }
                },
                width: mediaWidth * 0.9,
                label: "Reference",
              ),
              BorderlessDropdownMenuWidget(
                hintText: status,
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
                      status = status;
                    });
                  }
                },
                width: mediaWidth * 0.9,
                label: "Status",
              ),
              gapH20,
              const Divider(),
              SizedBox(
                width: mediaWidth * 0.9,
                child: const Text(
                  "Hi Darc, below this point is yet to be edited.\nLove Sam",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
              ),
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
                      dueDate = date.toString();
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
                textController: primaryClientNameController,
                hintText: "Contact Name",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.text,
              ),
              gapH20,
              CustomFieldWidget(
                textController: primaryClientEmailController,
                hintText: "Contact Email Address",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.emailAddress,
              ),
              gapH20,
              CustomFieldWidget(
                textController: primaryClientPhoneController,
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
                textController: secondaryClientNameController,
                hintText: "Contact Name",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.text,
              ),
              gapH20,
              CustomFieldWidget(
                textController: secondaryClientEmailController,
                hintText: "Contact Email Address",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
                keyboardType: TextInputType.emailAddress,
              ),
              gapH20,
              CustomFieldWidget(
                textController: secondaryClientPhoneController,
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
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    // showDialog(
                    //   context: context,
                    //   barrierDismissible: false,
                    //   builder: (BuildContext context) {
                    //     return const Center(
                    //       child: CircularProgressIndicator(
                    //         color: Colors.white,
                    //       ),
                    //     );
                    //   },
                    // );

                    // // Validate inputs
                    // try {
                    //   if (validate.validateTitle(titleController.text.trim()) !=
                    //       null) {
                    //     throw "Title is required";
                    //   }
                    //   if (validate.validateStreetAddress(
                    //           streetAddressController.text.trim()) !=
                    //       null) {
                    //     throw "Street Address is required";
                    //   }
                    //   if (validate.validateCity(cityController.text.trim()) !=
                    //       null) {
                    //     throw "City is required";
                    //   }
                    //   if (validate.validatePostcode(
                    //           postcodeController.text.trim()) !=
                    //       null) {
                    //     throw "Postcode is required";
                    //   }
                    //   if (validate.validatePrimaryContactName(
                    //           primaryClientNameController.text.trim()) !=
                    //       null) {
                    //     throw "Primary Contact Name is required";
                    //   }
                    //   if (validate.validateEmail(
                    //           primaryClientEmailController.text.trim()) !=
                    //       null) {
                    //     throw "Primary Contact Email is required";
                    //   }
                    //   if (validate.validatePhone(
                    //           primaryClientPhoneController.text.trim()) !=
                    //       null) {
                    //     throw "Primary Contact Phone is required";
                    //   }
                    // } catch (e) {
                    //   showMessage(e.toString());
                    // }

                    // // Create Client objects
                    // try {
                    //   const uuid = Uuid();
                    //   String projectId = uuid.v4();
                    //   final currentUser =
                    //       await db.getUser(userID: auth.user!.uid);

                    //   // Create Project object
                    //   final project = Project(
                    //     projectID: projectId,
                    //     companyID: currentUser.companyID,
                    //     projectTitle: titleController.text.trim(),
                    //     projectDescription: reference,
                    //     projectAddress1: streetAddressController.text.trim(),
                    //     projectCity: cityController.text.trim(),
                    //     projectState: geoState,
                    //     projectPostCode: postcodeController.text.trim(),
                    //     projectStatus: status,
                    //     projectDueDate: dueDate,
                    //     projectCreatedDate: DateTime.now().toString(),
                    //     primaryClientName:
                    //         primaryClientNameController.text.trim(),
                    //     primaryClientEmail:
                    //         primaryClientEmailController.text.trim(),
                    //     primaryClientPhone:
                    //         primaryClientPhoneController.text.trim(),
                    //     secondaryClientName:
                    //         secondaryClientNameController.text.trim(),
                    //     secondaryClientEmail:
                    //         secondaryClientEmailController.text.trim(),
                    //     secondaryClientPhone:
                    //         secondaryClientPhoneController.text.trim(),
                    //     projectNotes: [],
                    //     tasks: [],
                    //     labourCosts: {},
                    //     materialCosts: {},
                    //     totalCosts: 0.0,
                    //   );

                    //   // Save to Firestore
                    //   await db.addProject(project: project);
                    //   // ignore: use_build_context_synchronously
                    //   Navigator.pop(context);
                    //   showMessage("Project added!");
                    //   // ignore: use_build_context_synchronously
                    //   Beamer.of(context).beamToNamed('/projects');
                    // } catch (e) {
                    //   // ignore: use_build_context_synchronously
                    //   Navigator.pop(context);
                    //   showMessage(e.toString());
                    // }
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
