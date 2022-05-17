import 'package:dekut_cu/controllers/auth_controller.dart';
import 'package:dekut_cu/pages/root_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/auth.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );

  AuthController _authController = Get.find<AuthController>();

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

    if (_authController.user == null) {
      _navigateToAuthScreen(context);
    } else {
      _navigateToHomeScreen(context);
    }

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
