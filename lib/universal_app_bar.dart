import 'package:flutter/material.dart';
import 'package:next_gen_first_app/pages/monitor_page.dart';
import 'package:next_gen_first_app/pages/teams_page.dart';

class UniversalAppBar extends StatelessWidget {
  final ValueNotifier<String> title ;
  const UniversalAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: title,
          builder: (context, value, child) {
            return Text(value);
          }
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration( color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the settings screen
              },
            ),
          ],
        ),
      ),
      body: TeamsPage(titleNotifier: title),
      // body: MonitorPage(titleNotifier: title,),
    );
  }
}