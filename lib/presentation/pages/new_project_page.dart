import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO 11: Fill out new project page

class NewProjectPage extends ConsumerStatefulWidget {
  const NewProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends ConsumerState<NewProjectPage> {
  final _titleController = TextEditingController();
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
    _descriptionController.dispose();
    _statusController.dispose();
    _clientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // generate projectID with UUID
    // get companyID from user
    // Create projectTitle, projectDescription, projectDueDate, projectStatus,
    // projectCreatedDate, clientName
    // Set tasks, labourCosts, materialCosts to empty list
    // Set totalCosts to 0.0
    // Create object with above data and save to Firestore for display on Projects page
    return Container();
    // no bottom nav bar, just back button up top
  }
}
