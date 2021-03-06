import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/json/day_month.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:dekut_cu/widget/daily_devotion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int activeDay = 3;
  User user1 = FirebaseAuth.instance.currentUser;

  void _enterUserName() {
    final _key = GlobalKey<FormState>();
    String userName;
    Alert(
      context: context,
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
      ),
      title: "Username",
      desc: "Enter your username to continue.",
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      value.isEmpty ? 'Username can\'t be empty' : null,
                  onSaved: (value) => userName = value,
                  decoration: InputDecoration(
                    hintText: 'Enter username...',
                  ),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      buttons: [
        DialogButton(
          color: Colors.green,
          child: Text(
            "SAVE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (_key.currentState.validate()) {
              _key.currentState.save();
              user1.updateDisplayName(userName);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user1.uid)
                  .update({'name': userName}).then(
                      (value) => print("User Updated"));
              print('username : ' + userName);
              Get.back();
            }
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () async {
      if (user1.displayName == null) {
        _enterUserName();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Daily Devotionals",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Icon(AntDesign.search1)
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(days.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDay = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 40) / 7,
                            child: Column(
                              children: [
                                Text(
                                  days[index]['label'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: activeDay == index
                                          ? primary
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: activeDay == index
                                              ? primary
                                              : black.withOpacity(0.1))),
                                  child: Center(
                                    child: Text(
                                      days[index]['day'],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: activeDay == index
                                              ? white
                                              : black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("daily_studies")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final docs = snapshot.data.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> devotional = docs[index].data();
                      return DailyDevotion(
                        size: size,
                        date: devotional['date'],
                        teaching: devotional['teaching'],
                        title: devotional['title'],
                        verse: devotional['verse'],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
