import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/pages/auth/auth.dart';
import 'package:dekut_cu/pages/monthly_page.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:dekut_cu/widget/contact_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'events_page.dart';
import 'ministry_registration.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user;
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController(text: "04-19-1992");
  TextEditingController password = TextEditingController(text: "123456");
  @override
  Widget build(BuildContext context) {
    final litUser = context.getSignedInUser();
    litUser.when(
      (litUser) => user = litUser,
      empty: () {},
      initializing: () {},
    );
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(user),
    );
  }

  Widget getBody(User user) {
    var size = MediaQuery.of(context).size;
    _email.text = user.email;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            padding:
                const EdgeInsets.only(top: 60, right: 20, left: 20, bottom: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.signOut();
                        Get.off(AuthScreen());
                      },
                      child: Icon(AntDesign.logout),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Container(
                      width: (size.width - 40) * 0.4,
                      child: Container(
                        child: Stack(
                          children: [
                            RotatedBox(
                              quarterTurns: -2,
                              child: CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  backgroundColor: grey.withOpacity(0.3),
                                  radius: 110.0,
                                  lineWidth: 6.0,
                                  percent: 0.53,
                                  progressColor: primary),
                            ),
                            Positioned(
                              top: 16,
                              left: 13,
                              child: Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(user.photoURL !=
                                                null
                                            ? user.photoURL
                                            : "https://feedbackhall.com/uploads/user-icon.png"),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: (size.width - 40) * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName != null
                                ? user.displayName
                                : "No Username",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Email verified',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black.withOpacity(0.4)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Completed Devotionals",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Coming soon",
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  color: white),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(DevotionalsPage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: white)),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                "Continue",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      Text(
                        user.email == null ? '' : user.email,
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(MinistryRegistrationPage());
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: primary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ministries',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        Row(
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white70,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(EventPage());
                  },
                  child: ClipRect(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Events',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Row(
                            children: [
                              Text(
                                'Open',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white70,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Contact Us:",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Color(0xff67727d)),
          ),
        ),
        Flexible(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("contacts").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot != null) {
                final docs = snapshot.data.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final contact = docs[index].data();
                    print(contact);
                    return ContactCard(
                        phone: contact['phone'], name: contact['name']);
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
