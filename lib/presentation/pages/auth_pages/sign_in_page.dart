import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/utils/constants.dart';
import '../../state_management/providers.dart';
import '../../widgets/login_field_widget.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
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
    final mediaWidth = MediaQuery.of(context).size.width;
    final auth = ref.read(firebaseAuth);
    final db = ref.read(firestore);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final bool userLoggedIn = snapshot.data != null;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Sign In"),
            automaticallyImplyLeading: userLoggedIn ? true : false,
            leading: userLoggedIn
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Beamer.of(context).beamToNamed('/settings');
                    },
                  )
                : null,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: userLoggedIn
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Already signed in!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 40,
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
                            onPressed: () {
                              auth.signOut();
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            // delete account
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: const Text(
                                      'Are you sure you want to delete your account?',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          try {
                                            auth.deleteAccount();
                                            db.deleteUser(
                                                userID: auth.user!.uid);
                                          } catch (e) {
                                            showMessage(e.toString());
                                          } finally {
                                            Navigator.pop(context);
                                            Beamer.of(context)
                                                .beamToNamed('/sign-in');
                                          }
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text(
                            'Delete Account',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LoginFieldWidget(
                          textController: _emailController,
                          obscurePassword: false,
                          hintText: 'Email',
                          mediaWidth: mediaWidth,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                await auth.signIn(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                showMessage("User signed in!");
                                final user =
                                    await db.getUser(userID: auth.user!.uid);
                                user.companyID == ''
                                    // ignore: use_build_context_synchronously
                                    ? Beamer.of(context)
                                        .beamToNamed('/join-company')
                                    :
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
                            Beamer.of(context).beamToNamed('/sign-up');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Beamer.of(context).beamToNamed('/forgot-password');
                          },
                          child: const Text(
                            'Forgot Password?',
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
      },
    );
  }
}
