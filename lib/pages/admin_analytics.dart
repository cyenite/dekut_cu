import 'package:dekut_cu/config/palette.dart';
import 'package:dekut_cu/json/day_month.dart';
import 'package:dekut_cu/models/devotional.dart';
import 'package:dekut_cu/services/database_helper.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:dekut_cu/widget/analytic_container.dart';
import 'package:dekut_cu/widget/content_management_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AdminStats extends StatefulWidget {
  @override
  _AdminStatsState createState() => _AdminStatsState();
}

class _AdminStatsState extends State<AdminStats> {
  final GlobalKey<FormState> _reqFormKey = GlobalKey<FormState>();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _monthEditingController = TextEditingController();
  final TextEditingController _teachingEditingController =
      TextEditingController();
  int activeDay = 3;

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
                        "Admin Accessories",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Icon(AntDesign.search1),
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
                            width: (MediaQuery.of(context).size.width - 40) / 6,
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
                                        left: 12, right: 12, top: 7, bottom: 7),
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
                            ContentManagementContainer(
                              color: Palette.darkBlue,
                              detail: '',
                              label: 'Add Daily Bible Study',
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
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnalyticContainer(
                            color: Colors.deepOrange,
                            detail: snapshot.data['devotionalCount'].toString(),
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
                          AnalyticContainer(
                            color: Colors.deepOrange,
                            detail: snapshot.data['paymentCount'].toString(),
                            label: 'Total Payments',
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
              })
          /*StreamBuilder(
            stream: FirebaseFirestore.instance.collection("").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot != null) {
                final docs = snapshot.data.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final analytic = docs[index].data();
                    return AnalyticContainer(
                      label: analytic['label'],
                      detail: analytic['detail'],
                      color: primary,
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          )*/
        ],
      ),
    );
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
              title: Text('Add Quartely Devotional'),
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
                        decoration: InputDecoration(
                          hintText: "Write/paste teaching",
                        ),
                      ),
                    ],
                  )),
              title: Text('Add Quartely Devotional'),
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
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}
