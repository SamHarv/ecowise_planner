import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/utils/constants.dart';
import '../../state_management/providers.dart';
import '../../widgets/login_field_widget.dart';
import '/domain/model/user_model.dart';

class JoinCompanyPage extends ConsumerStatefulWidget {
  const JoinCompanyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JoinCompanyPageState();
}

class _JoinCompanyPageState extends ConsumerState<JoinCompanyPage> {
  final _companyCodeController = TextEditingController();

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
    _companyCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Company"),
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
                textController: _companyCodeController,
                obscurePassword: false,
                hintText: 'Company Code',
                mediaWidth: mediaWidth,
              ),
              gapH20,
              SizedBox(
                width: mediaWidth * 0.8,
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
                    try {
                      final currentUser =
                          await db.getUser(userID: auth.user!.uid);
                      await db.updateUser(
                          user: UserModel(
                        companyID: _companyCodeController.text.trim(),
                        email: currentUser.email,
                        firstName: currentUser.firstName,
                        surname: currentUser.surname,
                        userID: auth.user!.uid,
                      ));
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showMessage("Success!");
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
              gapH20,
              TextButton(
                onPressed: () {
                  Beamer.of(context).beamToNamed('/register-company');
                },
                child: const Text(
                  'Don\'t have a code? Register a Company',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              gapH20,
            ],
          ),
        ),
      ),
    );
  }
}
