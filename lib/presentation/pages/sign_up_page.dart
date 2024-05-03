import 'package:beamer/beamer.dart';
import 'package:ecowise_planner/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/state_management/providers.dart';
import '../../domain/utils/constants.dart';
import '../widgets/login_field_widget.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();

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
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(firestore);
    final auth = ref.read(firebaseAuth);
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LoginFieldWidget(
                textController: _firstNameController,
                obscurePassword: false,
                hintText: 'First Name',
                mediaWidth: mediaWidth,
              ),
              gapH20,
              LoginFieldWidget(
                textController: _surnameController,
                obscurePassword: false,
                hintText: 'Surname',
                mediaWidth: mediaWidth,
              ),
              gapH20,
              LoginFieldWidget(
                textController: _emailController,
                obscurePassword: false,
                hintText: 'Email',
                mediaWidth: mediaWidth,
              ),
              gapH20,
              LoginFieldWidget(
                textController: _passwordController,
                obscurePassword: true,
                hintText: 'Password',
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
                      await auth.signUp(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      final user = UserModel(
                        userID: auth.user!.uid,
                        companyID: '',
                        firstName: _firstNameController.text.trim(),
                        surname: _surnameController.text.trim(),
                        email: _emailController.text.trim(),
                      );
                      await db.addUser(user: user);
                      //ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showMessage("User created!");
                      //ignore: use_build_context_synchronously
                      Beamer.of(context).beamToNamed('/join-company');
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
                  Beamer.of(context).beamToNamed('/sign-in');
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
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
  }
}
