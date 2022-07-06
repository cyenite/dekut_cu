import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/controllers/auth_controller.dart';
import 'package:dekut_cu/pages/root_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper extends GetxController {
  RxBool isAdmin = false.obs;

  AuthController _authController = Get.find<AuthController>();
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  void saveAdminUser(String name, String email, String password) async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    Map<String, dynamic> userData = {
      "name": name,
      "email": email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "admin",
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "role": "admin",
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
  }

  static addNewUser(String name, String email, String password) async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    Map<String, dynamic> userData = {
      "name": name,
      "email": email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "user",
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "role": "user",
      }).then((value) {
        updatePreference(true);
        Get.to(() => RootApp());
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData).then((value) {
        updatePreference(true);
        Get.to(() => RootApp());
      });
    }
  }

  static signInUser(String email, String password) async {
    UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    final userRef = _db.collection("users").doc(user.uid);
    await userRef.update({
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
    }).then((value) {
      updatePreference(true);
      Get.to(() => RootApp());
    });
  }

  static saveUser(User user) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "user",
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
    updatePreference(true);
  }

  static saveUserMinistry(User user, String ministry) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "user",
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "ministry": ministry,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
  }

  static updatePreference(bool status) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("loggedIn", status);
  }

  static logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("loggedIn", false);
    await FirebaseAuth.instance.signOut();
  }
}
