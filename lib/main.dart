import 'package:dekut_cu/pages/root_app.dart';
import 'package:dekut_cu/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'config/palette.dart';
import 'controllers/ministry_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MinistryController());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      authProviders: const AuthProviders(
        emailAndPassword: true,
        google: true,
        apple: true,
        twitter: true,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DeKUT CU',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.muliTextTheme(),
          accentColor: Palette.darkOrange,
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: Palette.darkBlue,
          ),
        ),
        home: const LitAuthState(
          authenticated: RootApp(),
          unauthenticated: SplashScreen(),
        ),
        //home: const SplashScreen(),
      ),
    );
  }
}
