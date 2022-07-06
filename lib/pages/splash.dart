import 'package:dekut_cu/controllers/auth_controller.dart';
import 'package:dekut_cu/pages/root_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController _authController = Get.find<AuthController>();
  SharedPreferences _prefs;

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getBool("loggedIn") == null ||
        _prefs.getBool("loggedIn") == false) {
      _navigateToAuthScreen(context);
    } else {
      _navigateToHomeScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*final user = context.watchSignedInUser();
    user.map(
      (value) {
        _navigateToHomeScreen(context);
      },
      empty: (_) {
        _navigateToAuthScreen(context);
      },
      initializing: (_) {},
    );*/

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _navigateToAuthScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(AuthScreen.route),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(RootApp.route),
    );
  }
}
