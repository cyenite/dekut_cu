import 'package:dekut_cu/services/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MinistryController extends GetxController {
  var userMinistry = ''.obs;
  User user;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    user = auth.currentUser;
    updateMinistry();
    super.onInit();
  }

  updateMinistry() async {
    await DbHelper.getUserMinistry(user.uid)
        .then((value) => userMinistry(value));
  }
}
