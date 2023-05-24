import 'package:flutter/material.dart';
import 'package:next_gen_first_app/pages/monitor_page.dart';
import 'package:next_gen_first_app/pages/teams_page.dart';

class UniversalScaffold extends StatelessWidget {
  final ValueNotifier<String> title;
  final Widget body;

  const UniversalScaffold({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> titleNotifier = ValueNotifier<String>("Home");
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: title,
          builder: (context, value, child) {
            return Text(value);
          },
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
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => UniversalScaffold(
                      title: titleNotifier,
                      body: MonitorPage(titleNotifier: titleNotifier)
                    )
                  )
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_soccer),
              title: const Text('Teams'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => UniversalScaffold(
                      title: titleNotifier,
                      body: TeamsPage(titleNotifier: titleNotifier)
                    )
                  )
                );
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
      ),// Define your drawer here
      body: body,
    );
  }
}
