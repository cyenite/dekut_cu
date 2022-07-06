import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/services/database_helper.dart';
import 'package:dekut_cu/widget/ministry_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MinistryRegistrationPage extends StatefulWidget {
  @override
  _MinistryRegistrationPageState createState() =>
      _MinistryRegistrationPageState();
}

class _MinistryRegistrationPageState extends State<MinistryRegistrationPage> {
  bool isRegistering = false;
  User user = FirebaseAuth.instance.currentUser;
  String userMinistry;

  @override
  void initState() {
    updateMinistry();
    super.initState();
  }

  updateMinistry() async {
    user = FirebaseAuth.instance.currentUser;
    await DbHelper.getUserMinistry(user.uid).then((value) {
      return userMinistry = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ministries'),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /*Center(
              child: userMinistry != null
                  ? Text(
                      'Registered Ministry: $userMinistry',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  : CircularProgressIndicator(),
            ),*/
            StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data.uid == user.uid &&
                      snapshot.data != null) {
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(snapshot.data.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final userDoc = snapshot.data;
                          Map<String, dynamic> user = userDoc.data();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Registered ministry:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                ' ${user['ministry']}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ],
                          );
                        } else {
                          return Material(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    );
                  }
                  return Text('');
                }),
            SizedBox(
              height: 30.0,
            ),
            MinistryCard(
              title: 'Music Ministry',
              description: 'Description',
              status: isRegistering,
              user: user,
            ),
            MinistryCard(
              title: 'Ushering',
              description: 'Description',
              status: isRegistering,
              user: user,
            ),
            MinistryCard(
              title: 'Publicity',
              description: 'Description',
              status: isRegistering,
              user: user,
            ),
          ],
        ),
      ),
    );
  }
}
