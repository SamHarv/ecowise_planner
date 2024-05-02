import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/model/company_model.dart';
import '../../domain/model/user_model.dart';
import '../../domain/utils/constants.dart';
import '../state_management/providers.dart';
import '../widgets/login_field_widget.dart';

class CompanyRegistrationPage extends ConsumerStatefulWidget {
  const CompanyRegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompanyRegistrationPageState();
}

class _CompanyRegistrationPageState
    extends ConsumerState<CompanyRegistrationPage> {
  final _companyNameController = TextEditingController();

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
    _companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Register a Company"),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                auth.signOut();
                Beamer.of(context).beamToNamed('/sign-up');
              },
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LoginFieldWidget(
                    textController: _companyNameController,
                    obscurePassword: false,
                    hintText: 'Company Name',
                    mediaWidth: mediaWidth,
                  ),
                  gapH20,
                  SizedBox(
                    width: mediaWidth * 0.8,
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
                        try {
                          const uuid = Uuid();
                          String generatedId =
                              uuid.v4(); // Generate a random UUID
                          final company = Company(
                            name: _companyNameController.text.trim(),
                            companyID: generatedId,
                            employees: [],
                            projects: [],
                          );

                          await db.addCompany(company: company);

                          final currentUser =
                              await db.getUser(userID: auth.user!.uid);

                          await db.updateUser(
                              user: UserModel(
                            companyID: company.companyID,
                            email: currentUser.email,
                            firstName: currentUser.firstName,
                            surname: currentUser.surname,
                            userID: auth.user!.uid,
                          ));

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          showMessage("User signed in!");
                          // ignore: use_build_context_synchronously
                          Beamer.of(context).beamToNamed('/home');
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          showMessage(e.toString());
                        }
                      },
                      child: const Text(
                        'Go',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
