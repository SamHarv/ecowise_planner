import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/utils/constants.dart';
import '../state_management/providers.dart';
import '../widgets/login_field_widget.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordPageWidgetState();
}

class _ForgotPasswordPageWidgetState extends ConsumerState<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(firebaseAuth);
    final mediaWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Reset Password"),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Receive an email to\nreset your password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  gapH20,
                  LoginFieldWidget(
                    textController: _emailController,
                    obscurePassword: false,
                    hintText: 'Email',
                    mediaWidth: mediaWidth,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                          await auth.resetPassword(
                            email: _emailController.text.trim(),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          showMessage(
                              'Check your email to reset your password');
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
        // );
      },
    );
  }
}
