import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_gen_first_app/pages/monitor_page.dart';
import 'package:next_gen_first_app/universal_scaffold.dart';
import 'package:next_gen_first_app/utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]).then((_) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> titleNotifier = ValueNotifier<String>("Home");
    return MaterialApp(
      theme:  ThemeData.from(
          colorScheme:  const ColorScheme(
            brightness: Brightness.light,
            primary: primaryColor,
            onPrimary: Colors.white,
            secondary: secondaryColor,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            onBackground: Colors.black,
            surface: surfaceColor,
            background: backgroundColor, 
            onSurface: Colors.grey, 
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: UniversalScaffold(
        title: titleNotifier,
        body: MonitorPage(titleNotifier: titleNotifier),
        )
    );
  }
}
