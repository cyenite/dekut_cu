import 'package:dekut_cu/services/database_helper.dart';
import 'package:dekut_cu/widget/ministry_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class MinistryRegistrationPage extends StatefulWidget {
  @override
  _MinistryRegistrationPageState createState() =>
      _MinistryRegistrationPageState();
}

class _MinistryRegistrationPageState extends State<MinistryRegistrationPage> {
  bool isRegistering = false;
  User user;
  String userMinistry;

  @override
  void initState() {
    final litUser = context.getSignedInUser();
    litUser.when(
      (litUser) => user = litUser,
      empty: () {},
      initializing: () {},
    );
    updateMinistry();
    super.initState();
  }

  updateMinistry() async {
    await DbHelper.getUserMinistry(user.uid).then((value) {
      return userMinistry = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ministries'),
        actions: [
          GestureDetector(
            onTap: () {
              userMinistry = userMinistry;
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: userMinistry != null
                  ? Text(
                      'Registered Ministry: $userMinistry',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  : CircularProgressIndicator(),
            ),
            SizedBox(
              height: 30.0,
            ),
            MinistryCard(
              title: 'Music Ministry',
              description: 'Description',
              status: isRegistering,
            ),
            MinistryCard(
              title: 'Ushering',
              description: 'Description',
              status: isRegistering,
            ),
            MinistryCard(
              title: 'Publicity',
              description: 'Description',
              status: isRegistering,
            ),
          ],
        ),
      ),
    );
  }
}
