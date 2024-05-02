import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state_management/providers.dart';
import '../widgets/custom_bottom_nav_bar_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
        title: Text(companyName), // TODO: Get company name from db
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    height: 300,
                    width: double.infinity,
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
                            Text('Tasks'),
                            Text('- Task title/ description'),
                            Text('- Daily/ weekly/ monthly/ yearly view'),
                            Text('- Planned/ in progress/ complete'),
                            Text('- Stakeholder information'),
                            Text('- Start date, due date'),
                            Text('- Assigned to'),
                            Text('- Task costings - link to project costings'),
                            Text('- Employment labour'),
                            Text('- Gantt chart and calendar access under '
                                'projects and tasks pages'),
                            Text('- Link to project'),
                            Text('- Search Functionality'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    height: 300,
                    width: double.infinity,
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
                            Text('Projects'),
                            Text('- High level description'),
                            Text('- Stakeholder information'),
                            Text('- Start date, due date'),
                            Text('- Budget'),
                            Text('- Job costings under projects page'),
                            Text('- Employment labour'),
                            Text('- Gantt chart and calendar access under '
                                'projects and tasks pages'),
                            Text('- Client view'),
                            Text('- Link to tasks'),
                            Text('- Search Functionality'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
    );
  }
}
