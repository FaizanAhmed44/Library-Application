import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app_sample/features/auth/presntation/screen/login_screen.dart';
import 'package:library_app_sample/features/bottm_navigation/screen/navigation_bar.dart';

import 'package:library_app_sample/firebase_options.dart';
import 'package:library_app_sample/shared/theme/theme_modal.dart';

import 'package:provider/provider.dart';

late Box box1;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  box1 = await Hive.openBox('libraryApp');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ChangeNotifierProvider(
        create: (_) => TheamModal(),
        child: Consumer(
          builder: (context, TheamModal theamModal, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Example For Dark and Light Mode",
              theme: theamModal.isDark
                  ? ThemeData.dark().copyWith(
                      textTheme: GoogleFonts.abhayaLibreTextTheme(textTheme),
                      primaryTextTheme: const TextTheme())
                  : ThemeData.light().copyWith(
                      textTheme: GoogleFonts.abhayaLibreTextTheme(textTheme),
                      primaryTextTheme: const TextTheme()),
              // home: PdfUpload()
              home: box1.get('isLogedIn', defaultValue: false)
                  ? const BottomNavigationExample()
                  : const LoginScreen(),
            );
          },
        ));
  }
}
