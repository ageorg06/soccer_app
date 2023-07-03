import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_gen_first_app/pages/monitor_page.dart';
import 'package:next_gen_first_app/universal_scaffold.dart';

import 'utils/app_colors.dart';

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
      theme:  ThemeData(
        colorScheme: const ColorScheme(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          secondaryVariant: AppColors.secondaryVariantColor,
          surface: AppColors.surfaceColor,
          background: AppColors.backgroundColor,
          error: Colors.red,  // required, choose an appropriate color
          onPrimary: AppColors.onPrimaryColor,
          onSecondary: Colors.white,  // required, choose an appropriate color
          onSurface: Colors.black,  // required, choose an appropriate color
          onBackground: Colors.black,  // required, choose an appropriate color
          onError: Colors.white,  // required, choose an appropriate color
          brightness: Brightness.light,  // choose either light or dark
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
