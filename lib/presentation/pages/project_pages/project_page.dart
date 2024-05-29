import 'package:ecowise_planner/presentation/widgets/borderless_dropdown_menu_widget.dart';
import 'package:ecowise_planner/presentation/widgets/borderless_field_widget.dart';
import 'package:ecowise_planner/presentation/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:url_launcher/url_launcher.dart';

import '/domain/utils/constants.dart';

import '../../state_management/providers.dart';
import '../../widgets/custom_field_widget.dart';

import '../../../domain/model/project_model.dart';

//TODO 00: implement this page
// Take notes
// CRUD tasks
// See labour, material, and total costs if access
// See hours spent on project for employees if access
// Edit project and delete project buttons in app bar

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

  void launchEmail(String email) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailLaunchUri);
  }

  void _phoneCall(String phoneNumber) async {
    final call = Uri.parse('tel: $phoneNumber');
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      throw 'Could not launch $call';
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
    final primaryClientNameController =
        TextEditingController(text: widget.project.primaryClientName);
    final primaryClientEmailController =
        TextEditingController(text: widget.project.primaryClientEmail);
    final primaryClientPhoneController =
        TextEditingController(text: widget.project.primaryClientPhone);
    final secondaryClientNameController =
        TextEditingController(text: widget.project.secondaryClientName);
    final secondaryClientEmailController =
        TextEditingController(text: widget.project.secondaryClientEmail);
    final secondaryClientPhoneController =
        TextEditingController(text: widget.project.secondaryClientPhone);
    String geoState = widget.project.projectState;
    String reference = widget.project.projectDescription;
    String status = widget.project.projectStatus;
    String dueDate = widget.project.projectDueDate;
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
            // TODO 00: Save updates here
            Beamer.of(context).beamToNamed('/projects');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: mediaWidth,
            child: Column(
              children: [
                BorderlessFieldWidget(
                  width: mediaWidth * 0.9,
                  controller: titleController,
                  hintText: "Project Title",
                  fontSize: 20,
                  onChanged: (text) {
                    widget.project.projectTitle = text;
                  },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  onChanged: (text) {
                                    widget.project.projectAddress1 = text;
                                  },
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
                                  onChanged: (text) {
                                    widget.project.projectCity = text;
                                  },
                                ),
                                BorderlessDropdownMenuWidget(
                                  hintText: geoState,
                                  dropdownMenuEntries: const [
                                    DropdownMenuEntry(
                                        value: "VIC", label: "VIC"),
                                    DropdownMenuEntry(
                                        value: "NSW", label: "NSW"),
                                    DropdownMenuEntry(
                                        value: "QLD", label: "QLD"),
                                    DropdownMenuEntry(value: "SA", label: "SA"),
                                    DropdownMenuEntry(value: "WA", label: "WA"),
                                    DropdownMenuEntry(
                                        value: "TAS", label: "TAS"),
                                    DropdownMenuEntry(value: "NT", label: "NT"),
                                    DropdownMenuEntry(
                                        value: "ACT", label: "ACT"),
                                  ],
                                  onSelected: (state) {
                                    if (state != null) {
                                      setState(() {
                                        widget.project.projectState = state;
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
                                  onChanged: (text) {
                                    widget.project.projectPostCode = text;
                                  },
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
                    DropdownMenuEntry(
                        value: "Hybrid Home", label: "Hybrid Home"),
                    DropdownMenuEntry(value: "New Home", label: "New Home"),
                  ],
                  onSelected: (reference) {
                    if (reference != null) {
                      setState(() {
                        widget.project.projectDescription = reference;
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
                    DropdownMenuEntry(
                        value: "In Progress", label: "In Progress"),
                    DropdownMenuEntry(value: "Completed", label: "Completed"),
                    DropdownMenuEntry(value: "Cancelled", label: "Cancelled"),
                  ],
                  onSelected: (status) {
                    if (status != null) {
                      setState(() {
                        widget.project.projectStatus = status;
                      });
                    }
                  },
                  width: mediaWidth * 0.9,
                  label: "Status",
                ),
                SizedBox(
                  width: mediaWidth * 0.9,
                  child: Text(
                    "Created Date: ${DateTime.parse(widget.project.projectCreatedDate).day}-${DateTime.parse(widget.project.projectCreatedDate).month}-${DateTime.parse(widget.project.projectCreatedDate).year}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: mediaWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Due Date: ${DateTime.parse(widget.project.projectDueDate).day}-${DateTime.parse(widget.project.projectDueDate).month}-${DateTime.parse(widget.project.projectDueDate).year}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
                                            setState(() {
                                              widget.project.projectDueDate =
                                                  newDate;
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
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),

                BorderlessFieldWidget(
                  controller: primaryClientNameController,
                  hintText: "Contact Name",
                  width: mediaWidth * 0.9,
                  fontSize: 16,
                  label: const Text("Primary Contact"),
                  onChanged: (text) {
                    widget.project.primaryClientName = text;
                  },
                ),
                SizedBox(
                  width: mediaWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BorderlessFieldWidget(
                        controller: primaryClientEmailController,
                        hintText: "Contact Email Address",
                        width: mediaWidth * 0.43,
                        fontSize: 16,
                        label: const Text("Email"),
                        onChanged: (text) {
                          widget.project.primaryClientEmail = text;
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          launchEmail(primaryClientEmailController.text.trim());
                        },
                        icon: const Icon(Icons.email),
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
                        controller: primaryClientPhoneController,
                        hintText: "Contact Phone Number",
                        width: mediaWidth * 0.43,
                        fontSize: 16,
                        label: const Text("Phone"),
                        onChanged: (text) {
                          widget.project.primaryClientPhone = text;
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          _phoneCall(primaryClientPhoneController.text.trim());
                        },
                        icon: const Icon(Icons.phone),
                      ),
                    ],
                  ),
                ),

                // Check to see if secondary contact is present
                if (widget.project.secondaryClientName != null &&
                    widget.project.secondaryClientEmail != "")
                  Column(
                    children: [
                      BorderlessFieldWidget(
                        controller: secondaryClientNameController,
                        hintText: "Contact Name",
                        width: mediaWidth * 0.9,
                        fontSize: 16,
                        label: const Text("Secondary Contact"),
                        onChanged: (text) {
                          widget.project.secondaryClientName = text;
                        },
                      ),
                      SizedBox(
                        width: mediaWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BorderlessFieldWidget(
                              controller: secondaryClientEmailController,
                              hintText: "Contact Email Address",
                              width: mediaWidth * 0.43,
                              fontSize: 16,
                              label: const Text("Email"),
                              onChanged: (text) {
                                widget.project.secondaryClientEmail = text;
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                launchEmail(
                                    primaryClientEmailController.text.trim());
                              },
                              icon: const Icon(Icons.email),
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
                              controller: secondaryClientPhoneController,
                              hintText: "Contact Phone Number",
                              width: mediaWidth * 0.43,
                              fontSize: 16,
                              label: const Text("Phone"),
                              onChanged: (text) {
                                widget.project.secondaryClientPhone = text;
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                _phoneCall(
                                    secondaryClientPhoneController.text.trim());
                              },
                              icon: const Icon(Icons.phone),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 400,
                  width: mediaWidth * 0.9,
                  child: const Text(
                    "Hey Darc,\nStill planning to add notes, tasks, labour, "
                    "material, and total costs here.\nThen I will try to make it "
                    "look pretty.\nLove Sam xoxo",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                    ),
                  ),
                ),
                // Take notes
              ],
            ),
          ),
        ),
      ),
    );
    // no bottom nav bar, just back button up top
  }
}
