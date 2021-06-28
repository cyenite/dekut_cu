import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dekut_cu/config/palette.dart';
import 'package:dekut_cu/json/day_month.dart';
import 'package:dekut_cu/models/daily_study.dart';
import 'package:dekut_cu/models/devotional.dart';
import 'package:dekut_cu/services/auth_helper.dart';
import 'package:dekut_cu/services/database_helper.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:dekut_cu/widget/analytic_container.dart';
import 'package:dekut_cu/widget/content_management_container.dart';
import 'package:dekut_cu/widget/incoming_payment.dart';
import 'package:dekut_cu/widget/user_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AdminStats extends StatefulWidget {
  @override
  _AdminStatsState createState() => _AdminStatsState();
}

class _AdminStatsState extends State<AdminStats> {
  final GlobalKey<FormState> _reqFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _reqFormKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _reqFormKey3 = GlobalKey<FormState>();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _monthEditingController = TextEditingController();
  final TextEditingController _teachingEditingController =
      TextEditingController();
  final TextEditingController _title2EditingController =
      TextEditingController();
  final TextEditingController _verseEditingController = TextEditingController();
  final TextEditingController _teaching2EditingController =
      TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();

  int activeDay = 3;
  String _verseDay =
      DateFormat('dd/MM/yyyy  kk:mm').format(DateTime.now()).toString();

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
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
                          "Admin Accessories",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        GestureDetector(
                          onTap: () {
                            addAdminDialog();
                          },
                          child: Icon(AntDesign.adduser),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(months.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDay = index;
                              });
                            },
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 40) / 6,
                              child: Column(
                                children: [
                                  Text(
                                    months[index]['label'],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: activeDay == index
                                            ? primary
                                            : black.withOpacity(0.02),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: activeDay == index
                                                ? primary
                                                : black.withOpacity(0.1))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          top: 7,
                                          bottom: 7),
                                      child: Text(
                                        months[index]['day'],
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Content management",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: (size.width - 20),
                          height: 150,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  addQuarterlyDialog();
                                },
                                child: ContentManagementContainer(
                                  color: Palette.orange,
                                  detail: '',
                                  label: 'Add Quarterly Devotionals',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addDailyDialog();
                                },
                                child: ContentManagementContainer(
                                  color: Palette.darkBlue,
                                  detail: '',
                                  label: 'Add Daily Bible Study',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: DbHelper.getCountAnalytics(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnalyticContainer(
                              color: Colors.deepOrange,
                              detail:
                                  snapshot.data['devotionalCount'].toString(),
                              label: 'Total Devotionals',
                            ),
                            AnalyticContainer(
                              color: Colors.deepOrange,
                              detail: snapshot.data['userCount'].toString(),
                              label: 'Users',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                incomingPayments();
                              },
                              child: AnalyticContainer(
                                color: Colors.deepOrange,
                                detail:
                                    snapshot.data['paymentCount'].toString(),
                                label: 'Total Payments',
                              ),
                            ),
                            AnalyticContainer(
                              color: Colors.deepOrange,
                              detail: snapshot.data['studyCount'].toString(),
                              label: 'Total Bible Studies',
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User management",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Color(0xff67727d)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
                width: size.width - 10,
                height: size.height,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData && snapshot != null) {
                      final docs = snapshot.data.docs;
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = docs[index].data();
                          print(user);
                          return UserContainer(
                            size: size,
                            email: user['email'],
                            role: user['role'],
                            date: user['created_at'].toString(),
                            name: user['name'],
                          );
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  Future<void> addAdminDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _reqFormKey2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Name required";
                        },
                        decoration: InputDecoration(
                          hintText: "Name of admin",
                        ),
                      ),
                      TextFormField(
                        controller: _emailEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Email required";
                        },
                        decoration: InputDecoration(
                          hintText: "Enter email",
                        ),
                      ),
                    ],
                  )),
              title: Text('Add System Administrator'),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 13.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Text(
                      'Submit',
                    ),
                  ),
                  onTap: () async {
                    User user ;
                    if (_nameEditingController.text != null &&
                        _emailEditingController.text != null) {
                      print(user);
                      await AuthHelper.saveAdminUser(
                          user,
                          _nameEditingController.text,
                          _emailEditingController.text);
                      _nameEditingController.clear();
                      _emailEditingController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> addQuarterlyDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _reqFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titleEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Title required";
                        },
                        decoration: InputDecoration(
                          hintText: "Title of devotional",
                        ),
                      ),
                      TextFormField(
                        controller: _monthEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Month required";
                        },
                        decoration: InputDecoration(
                          hintText: "e.g. January...",
                        ),
                      ),
                      TextFormField(
                        controller: _teachingEditingController,
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : "Enter/paste teaching";
                        },
                        minLines: 7,
                        maxLines: 200,
                        decoration: InputDecoration(
                          hintText: "Write/paste teaching",
                        ),
                      ),
                    ],
                  )),
              title: Text('Add Quarterly Devotional'),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Palette.darkBlue,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 13.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Text(
                      'Submit',
                    ),
                  ),
                  onTap: () async {
                    if (_reqFormKey.currentState.validate()) {
                      await DbHelper.saveDevotional(Devotional(
                          month: _monthEditingController.text,
                          title: _titleEditingController.text,
                          teaching: _teachingEditingController.text));
                      _monthEditingController.clear();
                      _titleEditingController.clear();
                      _teachingEditingController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> addDailyDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _reqFormKey2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _title2EditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Title required";
                        },
                        decoration: InputDecoration(
                          hintText: "Title of devotional",
                        ),
                      ),
                      TextFormField(
                        controller: _verseEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Verse required";
                        },
                        decoration: InputDecoration(
                          hintText: "Enter theme verse",
                        ),
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        // Disable weekend days to select from the calendar
                        onChanged: (val) => _verseDay = val,
                        validator: (val) {
                          print(val);
                          return val.isNotEmpty
                              ? null
                              : "Please choose the study time";
                        },
                        onSaved: (val) => print(val),
                      ),
                      TextFormField(
                        controller: _teaching2EditingController,
                        validator: (value) {
                          return value.isNotEmpty
                              ? null
                              : "Enter/paste teaching";
                        },
                        minLines: 7,
                        maxLines: 200,
                        decoration: InputDecoration(
                          hintText: "Write/paste teaching",
                        ),
                      ),
                    ],
                  )),
              title: Text('Add Daily Study'),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Palette.darkBlue,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 13.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Text(
                      'Submit',
                    ),
                  ),
                  onTap: () async {
                    if (_reqFormKey2.currentState.validate()) {
                      await DbHelper.saveDailyStudy(
                        DailyStudy(
                            title: _title2EditingController.text,
                            verse: _verseEditingController.text,
                            date: _verseDay,
                            teaching: _teaching2EditingController.text),
                      );
                      _title2EditingController.clear();
                      _verseEditingController.clear();
                      _teaching2EditingController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> incomingPayments() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("payments")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final docs = snapshot.data.docs;
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final payment = docs[index].data();
                        return IncomingPayment(
                            phone: payment['phone'],
                            amount: payment['amount'],
                            category: payment['category']);
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              title: Text('Incoming payments'),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Palette.darkBlue,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 13.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Text(
                      'Close',
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }
}
