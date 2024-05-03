import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/domain/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/providers.dart';
import '../../widgets/custom_field_widget.dart';

// TODO 11: Fill out new project page - implement dropdowns and enums

class NewProjectPage extends ConsumerStatefulWidget {
  const NewProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends ConsumerState<NewProjectPage> {
  final _titleController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _statusController = TextEditingController();
  final _clientNameController = TextEditingController();

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
    _stateController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    _clientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
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
              CustomFieldWidget(
                textController: _titleController,
                hintText: "Project Title",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
              ),
              gapH20,
              CustomFieldWidget(
                textController: _streetAddressController,
                hintText: "Street Adress",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
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
                    ),
                    // gapW20,
                    CustomFieldWidget(
                      textController: _stateController,
                      hintText: "State",
                      textCapitalization: TextCapitalization.words,
                      width: mediaWidth * 0.43,
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
                    ),
                    // gapW20,
                    CustomFieldWidget(
                      textController: _countryController,
                      hintText: "Country",
                      textCapitalization: TextCapitalization.words,
                      width: mediaWidth * 0.43,
                    ),
                  ],
                ),
              ),
              gapH20,
              CustomFieldWidget(
                textController: _descriptionController,
                hintText: "Reference",
                textCapitalization: TextCapitalization.words,
                width: mediaWidth * 0.9,
              ),
            ],
          ),
        ),
      ),
    );
    // no bottom nav bar, just back button up top
  }
}
