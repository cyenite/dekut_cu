import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/pages/daily_page.dart';
import 'package:dekut_cu/pages/make_contribution.dart';
import 'package:dekut_cu/pages/monthly_page.dart';
import 'package:dekut_cu/pages/profile_page.dart';
import 'package:dekut_cu/pages/stats_page.dart';
import 'package:dekut_cu/services/auth_helper.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'admin_analytics.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const RootApp(),
      );
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  User user;
  int pageIndex = 0;
  List<Widget> pages = [
    DailyPage(),
    DevotionalsPage(),
    StatsPage(),
    ProfilePage(),
    ContributionPage()
  ];

  List<Widget> adminPages = [
    DailyPage(),
    DevotionalsPage(),
    AdminStats(),
    ProfilePage(),
    ContributionPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user;
    final litUser = context.getSignedInUser();
    litUser.when(
      (litUser) => user = litUser,
      empty: () {},
      initializing: () {},
    );
    AuthHelper.saveUser(user);
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data.uid == user.uid &&
              snapshot.data != null) {
            AuthHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if (user['role'] == 'admin') {
                    return adminApp();
                  } else {
                    return userApp();
                  }
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
          return adminApp();
        });
  }

  Widget userApp() {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              selectedTab(4);
            },
            child: Icon(
              Icons.add,
              size: 25,
            ),
            backgroundColor: Colors.pink
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget adminApp() {
    return Scaffold(
        body: getAdminBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              selectedTab(4);
            },
            child: Icon(
              Icons.add,
              size: 25,
            ),
            backgroundColor: Colors.pink
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getAdminBody() {
    return IndexedStack(
      index: pageIndex,
      children: adminPages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.md_calendar,
      Ionicons.md_book,
      Ionicons.md_stats,
      Ionicons.ios_person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
