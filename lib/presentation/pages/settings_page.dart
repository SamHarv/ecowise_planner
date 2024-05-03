import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/providers.dart';
import '../widgets/custom_bottom_nav_bar_widget.dart';

// TODO 99: add account info, pricing, settings, etc.

// TODO 55: Add functionality to share company ID

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String userName = "Loading...";

  Future<void> getUserName() async {
    final db = ref.read(firestore);
    final auth = ref.read(firebaseAuth);
    final user = await db.getUser(userID: auth.user!.uid);
    final name = user.firstName;
    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        title: InkWell(
          onTap: () => Beamer.of(context).beamToNamed('/sign-in'),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                  //Image.asset('images/d-train.png'),
                ),
              ),
              const SizedBox(width: 8),
              Text(userName),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text('Settings Page Coming Soon'),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
