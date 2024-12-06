import 'package:ecowise_planner/presentation/widgets/bottom_nav_bar_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/utils/constants.dart';
import '../state_management/providers.dart';
import '../widgets/custom_bottom_nav_bar_widget.dart';

// tab for finance

class ResourcesPage extends ConsumerStatefulWidget {
  const ResourcesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<ResourcesPage> {
  String companyName = "Loading...";
  Future<void> getCompanyName() async {
    final db = ref.read(firestore);
    final auth = ref.read(firebaseAuth);
    final user = await db.getUser(userID: auth.user!.uid);
    final companyID = user.companyID;
    final company = await db.getCompany(companyID: companyID);
    final name = company.name;
    setState(() {
      companyName = name;
    });
  }

  @override
  void initState() {
    getCompanyName();
    isSelected = [false, false, true, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
        centerTitle: false,
        title: Text('$companyName - Resources'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.,
              children: [
                gapH20,
                gapH20,
                gapH20,
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      'images/ecowise.png',
                      width: mediaWidth * 0.7,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                gapH20,
                gapH20,
                gapH20,
                Container(
                  height: 300,
                  width: mediaWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Resources Page Coming Soon'),
                        ],
                      ),
                    ),
                  ),
                ),
                gapH20,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
