import 'package:ecowise_planner/domain/model/task_model.dart';
import 'package:ecowise_planner/presentation/widgets/borderless_dropdown_menu_widget.dart';
import 'package:ecowise_planner/presentation/widgets/borderless_field_widget.dart';
import 'package:ecowise_planner/presentation/widgets/custom_dialog_widget.dart';
import 'package:ecowise_planner/presentation/widgets/custom_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:url_launcher/url_launcher.dart';

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
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectPageState();
}

class _ProjectPageState extends ConsumerState<TaskPage> {
  // bool editingAddress = false;
  // final tempMap = {
  //   'Now': [
  //     'Task 1',
  //     'Task 2',
  //     'Task 3',
  //     'Task 4',
  //     'Task 5',
  //     'Task 6',
  //   ],
  //   'Coming Up': [
  //     'Task 7',
  //     'Task 8',
  //     'Task 9',
  //     'Task 10',
  //     'Task 11',
  //     'Task 12',
  //   ],
  //   'Future': [
  //     'Task 13',
  //     'Task 14',
  //     'Task 15',
  //     'Task 16',
  //     'Task 17',
  //     'Task 18',
  //   ],
  // };
  // void showMessage(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.black,
  //         title: Center(
  //           child: Text(
  //             message,
  //             style: const TextStyle(color: Colors.white),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void launchMaps(String address) async {
  //   String encodedAddress = Uri.encodeFull(address);
  //   String googleUrl =
  //       'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
  //   if (await canLaunchUrl(Uri.parse(googleUrl))) {
  //     await launchUrl(Uri.parse(googleUrl));
  //   } else {
  //     throw 'Could not launch $googleUrl';
  //   }
  // }

  // void launchEmail(String email) async {
  //   final emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //   );
  //   await launchUrl(emailLaunchUri);
  // }

  // void _phoneCall(String phoneNumber) async {
  //   final call = Uri.parse('tel: $phoneNumber');
  //   if (await canLaunchUrl(call)) {
  //     launchUrl(call);
  //   } else {
  //     throw 'Could not launch $call';
  //   }
  // }

  // double calculateLabourCosts() {
  //   double labourCosts = 0;
  //   widget.project.labourCosts.forEach((key, value) {
  //     labourCosts += value;
  //   });
  //   return labourCosts;
  // }

  // double calculateMaterialCosts() {
  //   double materialCosts = 0;
  //   widget.project.materialCosts.forEach((key, value) {
  //     materialCosts += value;
  //   });
  //   return materialCosts;
  // }

  // double calculateTotalCosts() {
  //   double totalCosts = 0;
  //   widget.project.labourCosts.forEach((key, value) {
  //     totalCosts += value;
  //   });
  //   widget.project.materialCosts.forEach((key, value) {
  //     totalCosts += value;
  //   });
  //   return totalCosts;
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final titleController =
    //     TextEditingController(text: widget.project.projectTitle);
    // titleController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: titleController.text.length),
    // );
    // final streetAddressController =
    //     TextEditingController(text: widget.project.projectAddress1);
    // streetAddressController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: streetAddressController.text.length));
    // final cityController =
    //     TextEditingController(text: widget.project.projectCity);
    // cityController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: cityController.text.length));
    // final postcodeController =
    //     TextEditingController(text: widget.project.projectPostCode);
    // postcodeController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: postcodeController.text.length));
    // final primaryClientNameController =
    //     TextEditingController(text: widget.project.primaryClientName);
    // primaryClientNameController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: primaryClientNameController.text.length));
    // final primaryClientEmailController =
    //     TextEditingController(text: widget.project.primaryClientEmail);
    // primaryClientEmailController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: primaryClientEmailController.text.length));
    // final primaryClientPhoneController =
    //     TextEditingController(text: widget.project.primaryClientPhone);
    // primaryClientPhoneController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: primaryClientPhoneController.text.length));
    // final secondaryClientNameController =
    //     TextEditingController(text: widget.project.secondaryClientName);
    // secondaryClientNameController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: secondaryClientNameController.text.length));
    // final secondaryClientEmailController =
    //     TextEditingController(text: widget.project.secondaryClientEmail);
    // secondaryClientEmailController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: secondaryClientEmailController.text.length));
    // final secondaryClientPhoneController =
    //     TextEditingController(text: widget.project.secondaryClientPhone);
    // secondaryClientPhoneController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: secondaryClientPhoneController.text.length));
    // final projectNotesController =
    //     TextEditingController(text: widget.project.projectNotes);
    // projectNotesController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: projectNotesController.text.length));
    // final labourCostController = TextEditingController();
    // final materialCostController = TextEditingController();
    // final labourCostDescController = TextEditingController();
    // final materialCostDescController = TextEditingController();
    // String geoState = widget.project.projectState;
    // String reference = widget.project.projectDescription;
    // String status = widget.project.projectStatus;
    // String dueDate = widget.project.projectDueDate;
    // final mediaWidth = MediaQuery.of(context).size.width;
    // final auth = ref.read(firebaseAuth);
    // final db = ref.read(firestore);
    // final validate = ref.read(validation);
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
            Beamer.of(context).beamToNamed('/projects');
            //         showDialog(
            //           context: context,
            //           barrierDismissible: false,
            //           builder: (BuildContext context) {
            //             return const Center(
            //               child: CircularProgressIndicator(
            //                 color: Colors.white,
            //               ),
            //             );
            //           },
            //         );

            //         try {
            //           if (validate.validateTitle(titleController.text.trim()) != null) {
            //             throw "Title is required";
            //           }
            //           if (validate.validateStreetAddress(
            //                   streetAddressController.text.trim()) !=
            //               null) {
            //             throw "Street Address is required";
            //           }
            //           if (validate.validateCity(cityController.text.trim()) != null) {
            //             throw "City is required";
            //           }
            //           if (validate.validatePostcode(postcodeController.text.trim()) !=
            //               null) {
            //             throw "Postcode is required";
            //           }
            //           if (validate.validatePrimaryContactName(
            //                   primaryClientNameController.text.trim()) !=
            //               null) {
            //             throw "Primary Contact Name is required";
            //           }
            //           if (validate.validateEmail(
            //                   primaryClientEmailController.text.trim()) !=
            //               null) {
            //             throw "Primary Contact Email is required";
            //           }
            //           if (validate.validatePhone(
            //                   primaryClientPhoneController.text.trim()) !=
            //               null) {
            //             throw "Primary Contact Phone is required";
            //           }
            //         } catch (e) {
            //           showMessage(e.toString());
            //         }

            //         // Create Client objects
            //         try {
            //           final currentUser = await db.getUser(userID: auth.user!.uid);

            //           // Create Project object
            //           final project = Project(
            //             projectID: widget.project.projectID,
            //             companyID: currentUser.companyID,
            //             projectTitle: titleController.text.trim(),
            //             projectDescription: reference,
            //             projectAddress1: widget.project.projectAddress1,
            //             projectCity: cityController.text.trim(),
            //             projectState: geoState,
            //             projectPostCode: postcodeController.text.trim(),
            //             projectStatus: status,
            //             projectDueDate: dueDate,
            //             projectCreatedDate: widget.project.projectCreatedDate,
            //             primaryClientName: primaryClientNameController.text.trim(),
            //             primaryClientEmail: primaryClientEmailController.text.trim(),
            //             primaryClientPhone: primaryClientPhoneController.text.trim(),
            //             secondaryClientName: secondaryClientNameController.text.trim(),
            //             secondaryClientEmail:
            //                 secondaryClientEmailController.text.trim(),
            //             secondaryClientPhone:
            //                 secondaryClientPhoneController.text.trim(),
            //             projectNotes: projectNotesController.text.trim(),
            //             tasks: [], // TODO 11: Tasks
            //             labourCosts: widget.project.labourCosts,
            //             materialCosts: widget.project.materialCosts,
            //             totalCosts: widget.project.totalCosts,
            //           );

            //           // Save to Firestore
            //           await db.updateProject(project: project);

            //           // ignore: use_build_context_synchronously
            //           Navigator.pop(context);
            //           showMessage("Project updated!");
            //           // ignore: use_build_context_synchronously
            //           Beamer.of(context).beamToNamed('/projects');
            //         } catch (e) {
            //           // ignore: use_build_context_synchronously
            //           Navigator.pop(context);
            //           showMessage(e.toString());
            //         }
          },
        ),
      ),
      body: const Center(
        child: Text("Task Page Coming Soon!"),
        //     child: SingleChildScrollView(
        //       child: SizedBox(
        //         width: mediaWidth,
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.only(top: 16, bottom: 16),
        //               child: BorderlessFieldWidget(
        //                 width: mediaWidth * 0.9,
        //                 controller: titleController,
        //                 hintText: "Project Title",
        //                 fontSize: 20,
        //                 onChanged: (text) {
        //                   widget.project.projectTitle = text;
        //                 },
        //               ),
        //             ),
        //             !editingAddress
        //                 ? Container(
        //                     decoration: BoxDecoration(
        //                       color: Colors.black54,
        //                       border: Border.all(
        //                         color: Colors.grey,
        //                         width: 1,
        //                       ),
        //                       borderRadius: BorderRadius.circular(24),
        //                     ),
        //                     width: mediaWidth * 0.9,
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsets.all(16),
        //                           child: Text(
        //                             "${widget.project.projectAddress1}\n"
        //                             "${widget.project.projectCity}\n"
        //                             "${widget.project.projectState} "
        //                             "${widget.project.projectPostCode}\nAustralia",
        //                             style: const TextStyle(
        //                               fontSize: 18,
        //                               color: Colors.white,
        //                             ),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(right: 16),
        //                           child: Column(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               IconButton(
        //                                 onPressed: () {
        //                                   setState(() {
        //                                     editingAddress = true;
        //                                   });
        //                                 },
        //                                 icon: const Icon(
        //                                   Icons.edit,
        //                                   color: Colors.white,
        //                                 ),
        //                               ),
        //                               gapH20,
        //                               IconButton(
        //                                 onPressed: () {
        //                                   launchMaps(
        //                                       "${widget.project.projectAddress1}, "
        //                                       "${widget.project.projectCity}, "
        //                                       "${widget.project.projectState}, "
        //                                       "${widget.project.projectPostCode}"
        //                                       ", Australia");
        //                                 },
        //                                 icon: const Icon(
        //                                   Icons.location_on,
        //                                   color: Colors.white,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   )
        //                 : Container(
        //                     decoration: BoxDecoration(
        //                       color: Colors.black54,
        //                       border: Border.all(
        //                         color: Colors.grey,
        //                         width: 1,
        //                       ),
        //                       borderRadius: BorderRadius.circular(24),
        //                     ),
        //                     child: Padding(
        //                       padding: const EdgeInsets.all(16),
        //                       child: Column(
        //                         children: [
        //                           SizedBox(
        //                             width: mediaWidth * 0.9 - 32,
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 BorderlessFieldWidget(
        //                                   width: mediaWidth * 0.43 - 16,
        //                                   controller: streetAddressController,
        //                                   hintText: "Street Address",
        //                                   fontSize: 16,
        //                                   onChanged: (text) {
        //                                     widget.project.projectAddress1 = text;
        //                                   },
        //                                 ),
        //                                 Padding(
        //                                   padding: const EdgeInsets.only(right: 4),
        //                                   child: IconButton(
        //                                     onPressed: () {
        //                                       setState(() {
        //                                         editingAddress = false;
        //                                       });
        //                                     },
        //                                     icon: const Icon(
        //                                       Icons.close,
        //                                       color: Colors.white,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: mediaWidth * 0.9 - 32,
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 BorderlessFieldWidget(
        //                                   width: mediaWidth * 0.43 - 16,
        //                                   controller: cityController,
        //                                   hintText: "City",
        //                                   fontSize: 16,
        //                                   onChanged: (text) {
        //                                     widget.project.projectCity = text;
        //                                   },
        //                                 ),
        //                                 BorderlessDropdownMenuWidget(
        //                                   hintText: geoState,
        //                                   dropdownMenuEntries: const [
        //                                     DropdownMenuEntry(
        //                                         value: "VIC", label: "VIC"),
        //                                     DropdownMenuEntry(
        //                                         value: "NSW", label: "NSW"),
        //                                     DropdownMenuEntry(
        //                                         value: "QLD", label: "QLD"),
        //                                     DropdownMenuEntry(
        //                                         value: "SA", label: "SA"),
        //                                     DropdownMenuEntry(
        //                                         value: "WA", label: "WA"),
        //                                     DropdownMenuEntry(
        //                                         value: "TAS", label: "TAS"),
        //                                     DropdownMenuEntry(
        //                                         value: "NT", label: "NT"),
        //                                     DropdownMenuEntry(
        //                                         value: "ACT", label: "ACT"),
        //                                   ],
        //                                   onSelected: (state) {
        //                                     if (state != null) {
        //                                       setState(() {
        //                                         widget.project.projectState = state;
        //                                       });
        //                                     }
        //                                   },
        //                                   width: mediaWidth * 0.43 - 16,
        //                                   label: "State",
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: mediaWidth * 0.9 - 32,
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 BorderlessFieldWidget(
        //                                   width: mediaWidth * 0.43 - 16,
        //                                   controller: postcodeController,
        //                                   hintText: "Postcode",
        //                                   fontSize: 16,
        //                                   onChanged: (text) {
        //                                     widget.project.projectPostCode = text;
        //                                   },
        //                                 ),
        //                                 BorderlessDropdownMenuWidget(
        //                                   hintText: "Australia",
        //                                   dropdownMenuEntries: const [
        //                                     DropdownMenuEntry(
        //                                         value: "Australia",
        //                                         label: "Australia"),
        //                                   ],
        //                                   onSelected: (country) {
        //                                     if (country != null) {
        //                                       setState(() {
        //                                         // _country = country;
        //                                       });
        //                                     }
        //                                   },
        //                                   width: mediaWidth * 0.43 - 16,
        //                                   label: "Country",
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //             gapH20,
        //             BorderlessDropdownMenuWidget(
        //               hintText: reference,
        //               dropdownMenuEntries: const [
        //                 DropdownMenuEntry(
        //                     value: "Hybrid Home", label: "Hybrid Home"),
        //                 DropdownMenuEntry(value: "New Home", label: "New Home"),
        //               ],
        //               onSelected: (reference) {
        //                 if (reference != null) {
        //                   setState(() {
        //                     widget.project.projectDescription = reference;
        //                   });
        //                 }
        //               },
        //               width: mediaWidth * 0.9 - 32,
        //               label: "Reference",
        //             ),
        //             BorderlessDropdownMenuWidget(
        //               hintText: status,
        //               dropdownMenuEntries: const [
        //                 DropdownMenuEntry(value: "Backlog", label: "Backlog"),
        //                 DropdownMenuEntry(value: "Pending", label: "Pending"),
        //                 DropdownMenuEntry(
        //                     value: "In Progress", label: "In Progress"),
        //                 DropdownMenuEntry(value: "Completed", label: "Completed"),
        //                 DropdownMenuEntry(value: "Cancelled", label: "Cancelled"),
        //               ],
        //               onSelected: (status) {
        //                 if (status != null) {
        //                   setState(() {
        //                     widget.project.projectStatus = status;
        //                   });
        //                 }
        //               },
        //               width: mediaWidth * 0.9 - 32,
        //               label: "Status",
        //             ),
        //             gapH20,
        //             Container(
        //               decoration: BoxDecoration(
        //                 color: Colors.black54,
        //                 border: Border.all(
        //                   color: Colors.grey,
        //                   width: 1,
        //                 ),
        //                 borderRadius: BorderRadius.circular(24),
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.all(16),
        //                 child: Column(
        //                   children: [
        //                     BorderlessFieldWidget(
        //                       controller: primaryClientNameController,
        //                       hintText: "Contact Name",
        //                       width: mediaWidth * 0.9 - 32,
        //                       fontSize: 16,
        //                       label: const Text("Primary Contact"),
        //                       onChanged: (text) {
        //                         widget.project.primaryClientName = text;
        //                       },
        //                     ),
        //                     SizedBox(
        //                       width: mediaWidth * 0.9 - 32,
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           BorderlessFieldWidget(
        //                             controller: primaryClientEmailController,
        //                             hintText: "Contact Email Address",
        //                             width: mediaWidth * 0.7,
        //                             fontSize: 16,
        //                             label: const Text("Email"),
        //                             onChanged: (text) {
        //                               widget.project.primaryClientEmail = text;
        //                             },
        //                           ),
        //                           IconButton(
        //                             onPressed: () {
        //                               launchEmail(
        //                                   primaryClientEmailController.text.trim());
        //                             },
        //                             icon: const Icon(Icons.email),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       width: mediaWidth * 0.9 - 32,
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           BorderlessFieldWidget(
        //                             controller: primaryClientPhoneController,
        //                             hintText: "Contact Phone Number",
        //                             width: mediaWidth * 0.43 - 16,
        //                             fontSize: 16,
        //                             label: const Text("Phone"),
        //                             onChanged: (text) {
        //                               widget.project.primaryClientPhone = text;
        //                             },
        //                           ),
        //                           IconButton(
        //                             onPressed: () {
        //                               _phoneCall(
        //                                   primaryClientPhoneController.text.trim());
        //                             },
        //                             icon: const Icon(Icons.phone),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             gapH20,

        //             // Check to see if secondary contact is present
        //             if (widget.project.secondaryClientName != null &&
        //                 widget.project.secondaryClientEmail != "")
        //               Container(
        //                 decoration: BoxDecoration(
        //                   color: Colors.black54,
        //                   border: Border.all(
        //                     color: Colors.grey,
        //                     width: 1,
        //                   ),
        //                   borderRadius: BorderRadius.circular(24),
        //                 ),
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(16),
        //                   child: Column(
        //                     children: [
        //                       BorderlessFieldWidget(
        //                         controller: secondaryClientNameController,
        //                         hintText: "Contact Name",
        //                         width: mediaWidth * 0.9 - 32,
        //                         fontSize: 16,
        //                         label: const Text("Secondary Contact"),
        //                         onChanged: (text) {
        //                           widget.project.secondaryClientName = text;
        //                         },
        //                       ),
        //                       SizedBox(
        //                         width: mediaWidth * 0.9 - 32,
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             BorderlessFieldWidget(
        //                               controller: secondaryClientEmailController,
        //                               hintText: "Contact Email Address",
        //                               width: mediaWidth * 0.7,
        //                               fontSize: 16,
        //                               label: const Text("Email"),
        //                               onChanged: (text) {
        //                                 widget.project.secondaryClientEmail = text;
        //                               },
        //                             ),
        //                             IconButton(
        //                               onPressed: () {
        //                                 launchEmail(primaryClientEmailController
        //                                     .text
        //                                     .trim());
        //                               },
        //                               icon: const Icon(Icons.email),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         width: mediaWidth * 0.9 - 32,
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             BorderlessFieldWidget(
        //                               controller: secondaryClientPhoneController,
        //                               hintText: "Contact Phone Number",
        //                               width: mediaWidth * 0.43 - 16,
        //                               fontSize: 16,
        //                               label: const Text("Phone"),
        //                               onChanged: (text) {
        //                                 widget.project.secondaryClientPhone = text;
        //                               },
        //                             ),
        //                             IconButton(
        //                               onPressed: () {
        //                                 _phoneCall(secondaryClientPhoneController
        //                                     .text
        //                                     .trim());
        //                               },
        //                               icon: const Icon(Icons.phone),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             gapH20,
        //             SizedBox(
        //               width: mediaWidth * 0.9 - 32,
        //               child: Text(
        //                 "Created: ${DateTime.parse(widget.project.projectCreatedDate).day}-${DateTime.parse(widget.project.projectCreatedDate).month}-${DateTime.parse(widget.project.projectCreatedDate).year}",
        //                 style: const TextStyle(
        //                   fontSize: 16,
        //                   color: Colors.grey,
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               width: mediaWidth * 0.9 - 32,
        //               child: Row(
        //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     "Due Date: ${DateTime.parse(widget.project.projectDueDate).day}-${DateTime.parse(widget.project.projectDueDate).month}-${DateTime.parse(widget.project.projectDueDate).year}",
        //                     style: const TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.grey,
        //                     ),
        //                   ),
        //                   IconButton(
        //                     onPressed: () async {
        //                       await showDialog(
        //                         context: context,
        //                         builder: (context) {
        //                           String newDate = "";
        //                           return StatefulBuilder(
        //                             builder: (context, setState) {
        //                               return Center(
        //                                 child: CustomDialogWidget(
        //                                   dialogHeading: "Select Due Date",
        //                                   dialogContent: SizedBox(
        //                                     width: mediaWidth * 0.9,
        //                                     child: CalendarDatePicker(
        //                                       initialDate: DateTime.now(),
        //                                       firstDate: DateTime.now(),
        //                                       lastDate: DateTime(2100, 12, 31),
        //                                       onDateChanged: (date) {
        //                                         setState(() {
        //                                           newDate = date.toString();
        //                                         });
        //                                       },
        //                                     ),
        //                                   ),
        //                                   dialogActions: [
        //                                     TextButton(
        //                                       onPressed: () {
        //                                         Navigator.pop(context);
        //                                       },
        //                                       child: const Text(
        //                                         "Cancel",
        //                                         style:
        //                                             TextStyle(color: Colors.white),
        //                                       ),
        //                                     ),
        //                                     TextButton(
        //                                       onPressed: () {
        //                                         setState(() {
        //                                           widget.project.projectDueDate =
        //                                               newDate;
        //                                         });
        //                                         Navigator.pop(context);
        //                                       },
        //                                       child: const Text(
        //                                         "Save",
        //                                         style:
        //                                             TextStyle(color: Colors.white),
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               );
        //                             },
        //                           );
        //                         },
        //                       );
        //                       setState(() {});
        //                     },
        //                     icon: const Icon(Icons.edit),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             gapH20,
        //             Container(
        //               // height: 200,
        //               decoration: BoxDecoration(
        //                 color: Colors.black54,
        //                 border: Border.all(
        //                   color: Colors.grey,
        //                   width: 1,
        //                 ),
        //                 borderRadius: BorderRadius.circular(24),
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.all(16),
        //                 child: BorderlessFieldWidget(
        //                   inputType: TextInputType.multiline,
        //                   maxLines: 200,
        //                   minLines: 3,
        //                   width: mediaWidth * 0.9 - 32,
        //                   controller: projectNotesController,
        //                   hintText: "Notes",
        //                   fontSize: 16,
        //                   onChanged: (text) {
        //                     widget.project.projectNotes = text;
        //                   },
        //                 ),
        //               ),
        //             ),
        //             gapH20,
        //             SizedBox(
        //               width: mediaWidth * 0.9 - 32,
        //               child: const Text(
        //                 "Tasks",
        //                 style: TextStyle(fontSize: 18, color: Colors.grey),
        //               ),
        //             ),
        //             gapH20,
        //             // TODO 11: implement tasks here properly
        //             Container(
        //               width: mediaWidth * 0.9,
        //               height: 300,
        //               decoration: BoxDecoration(
        //                 color: Colors.black54,
        //                 border: Border.all(
        //                   color: Colors.grey,
        //                   width: 1,
        //                 ),
        //                 borderRadius: BorderRadius.circular(24),
        //               ),
        //               child: ListView(
        //                 children: [
        //                   for (int index = 0; index < tempMap.length; index++)
        //                     ExpansionTile(
        //                       shape: index == 0
        //                           ? const RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(24),
        //                                 topRight: Radius.circular(24),
        //                               ),
        //                             )
        //                           : null,
        //                       collapsedShape: index == 0
        //                           ? const RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(24),
        //                                 topRight: Radius.circular(24),
        //                               ),
        //                             )
        //                           : null,
        //                       title: Text(
        //                         tempMap.keys.elementAt(index),
        //                         style: const TextStyle(fontWeight: FontWeight.bold),
        //                       ),
        //                       children: tempMap.values
        //                           .elementAt(index)
        //                           .map((e) => ListTile(title: Text(e)))
        //                           .toList(),
        //                     ),
        //                 ],
        //               ),
        //             ),
        //             gapH20,
        //             SizedBox(
        //               width: mediaWidth * 0.9 - 32,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         "Labour Costs: \$${calculateLabourCosts()}",
        //                         style: const TextStyle(
        //                           fontSize: 16,
        //                           color: Colors.grey,
        //                         ),
        //                       ),
        //                       Text(
        //                         "Material Costs: \$${calculateMaterialCosts()}",
        //                         style: const TextStyle(
        //                           fontSize: 16,
        //                           color: Colors.grey,
        //                         ),
        //                       ),
        //                       Text(
        //                         "Total Costs: \$${calculateTotalCosts()}",
        //                         style: const TextStyle(
        //                           fontSize: 16,
        //                           color: Colors.grey,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   FloatingActionButton(
        //                     child: const Center(
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             "Add",
        //                             style: TextStyle(color: Colors.white),
        //                           ),
        //                           Text(
        //                             "Costs",
        //                             style: TextStyle(color: Colors.white),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                     onPressed: () async {
        //                       await showDialog(
        //                         context: context,
        //                         builder: (context) {
        //                           var selected = {CostType.labour};
        //                           return StatefulBuilder(
        //                             builder: (context, setState) {
        //                               return Center(
        //                                 child: CustomDialogWidget(
        //                                   dialogHeading: "Add Costs",
        //                                   dialogContent: SizedBox(
        //                                     width: mediaWidth * 0.9,
        //                                     child: Column(
        //                                       mainAxisSize: MainAxisSize.min,
        //                                       children: [
        //                                         SegmentedButton(
        //                                           segments: const [
        //                                             ButtonSegment(
        //                                               value: CostType.labour,
        //                                               label: Text("Labour"),
        //                                             ),
        //                                             ButtonSegment(
        //                                               value: CostType.material,
        //                                               label: Text("Material"),
        //                                             ),
        //                                           ],
        //                                           selected: selected,
        //                                           onSelectionChanged:
        //                                               (Set<CostType> newSelection) {
        //                                             setState(() {
        //                                               selected = newSelection;
        //                                             });
        //                                             setState(() {});
        //                                           },
        //                                         ),
        //                                         gapH20,
        //                                         CustomFieldWidget(
        //                                           textController: selected
        //                                                       .toString() ==
        //                                                   {CostType.labour}
        //                                                       .toString()
        //                                               ? labourCostDescController
        //                                               : materialCostDescController,
        //                                           hintText: "Description",
        //                                           textCapitalization:
        //                                               TextCapitalization.none,
        //                                           width: mediaWidth * 0.8,
        //                                           keyboardType:
        //                                               TextInputType.multiline,
        //                                           maxLines: 20,
        //                                         ),
        //                                         gapH20,
        //                                         CustomFieldWidget(
        //                                           textController:
        //                                               selected.toString() ==
        //                                                       {CostType.labour}
        //                                                           .toString()
        //                                                   ? labourCostController
        //                                                   : materialCostController,
        //                                           hintText: "Amount (\$)",
        //                                           textCapitalization:
        //                                               TextCapitalization.none,
        //                                           width: mediaWidth * 0.8,
        //                                           keyboardType:
        //                                               TextInputType.number,
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                   dialogActions: [
        //                                     TextButton(
        //                                       onPressed: () {
        //                                         Navigator.pop(context);
        //                                       },
        //                                       child: const Text(
        //                                         "Cancel",
        //                                         style:
        //                                             TextStyle(color: Colors.white),
        //                                       ),
        //                                     ),
        //                                     TextButton(
        //                                       onPressed: () {
        //                                         setState(() {
        //                                           if (selected.toString() ==
        //                                               {CostType.labour}
        //                                                   .toString()) {
        //                                             widget.project.labourCosts[
        //                                                 labourCostDescController
        //                                                     .text] = double.parse(
        //                                                 labourCostController.text);
        //                                           } else if (selected.toString() ==
        //                                               {CostType.material}
        //                                                   .toString()) {
        //                                             widget.project.materialCosts[
        //                                                 materialCostDescController
        //                                                     .text] = double.parse(
        //                                                 materialCostController
        //                                                     .text);
        //                                           }
        //                                         });
        //                                         Navigator.pop(context);
        //                                       },
        //                                       child: const Text(
        //                                         "Save",
        //                                         style:
        //                                             TextStyle(color: Colors.white),
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               );
        //                             },
        //                           );
        //                         },
        //                       );
        //                       setState(() {});
        //                     },
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             // TODO 11: Work out the best way to view and interact with costs

        //             gapH20,
        //             Divider(
        //               indent: mediaWidth * 0.05,
        //               endIndent: mediaWidth * 0.05,
        //             ),
        //             gapH20,
        //             ElevatedButton(
        //               style: ButtonStyle(
        //                 backgroundColor: WidgetStateProperty.all(Colors.red),
        //               ),
        //               onPressed: () {
        //                 showDialog(
        //                   context: context,
        //                   builder: (context) {
        //                     return AlertDialog(
        //                       backgroundColor: Colors.black,
        //                       title: const Text(
        //                         "Delete Project",
        //                         style: TextStyle(color: Colors.white),
        //                       ),
        //                       content: const Text(
        //                         "Are you sure you want to delete this project?",
        //                         style: TextStyle(color: Colors.white),
        //                       ),
        //                       actions: [
        //                         TextButton(
        //                           onPressed: () {
        //                             Navigator.pop(context);
        //                           },
        //                           child: const Text(
        //                             "Cancel",
        //                             style: TextStyle(color: Colors.white),
        //                           ),
        //                         ),
        //                         TextButton(
        //                           onPressed: () async {
        //                             final currentUser =
        //                                 await db.getUser(userID: auth.user!.uid);
        //                             await db.deleteProject(
        //                               projectID: widget.project.projectID,
        //                               companyID: currentUser.companyID,
        //                             );
        //                             // ignore: use_build_context_synchronously
        //                             Beamer.of(context).beamToNamed('/projects');
        //                           },
        //                           child: const Text(
        //                             "Delete",
        //                             style: TextStyle(color: Colors.white),
        //                           ),
        //                         ),
        //                       ],
        //                     );
        //                   },
        //                 );
        //               },
        //               child: const Text(
        //                 "Delete Project",
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //             ),
        //             gapH20,
        //           ],
        //         ),
        //       ),
        //     ),
      ),
    );
    // no bottom nav bar, just back button up top
  }
}
