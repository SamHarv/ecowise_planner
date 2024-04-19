import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import '/domain/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: EcowisePlanner()));
}

class EcowisePlanner extends StatelessWidget {
  const EcowisePlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ecowise Planner',
      debugShowCheckedModeBanner: false,
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      themeMode: ThemeMode.system,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
    );
  }
}
