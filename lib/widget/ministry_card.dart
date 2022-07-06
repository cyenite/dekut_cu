import 'package:dekut_cu/services/auth_helper.dart';
import 'package:dekut_cu/services/database_helper.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MinistryCard extends StatefulWidget {
  final String title;
  final String description;
  bool status;
  Function onClick;
  User user;

  MinistryCard(
      {this.description,
      this.title,
      this.status,
      this.onClick,
      @required this.user});

  @override
  _MinistryCardState createState() => _MinistryCardState();
}

class _MinistryCardState extends State<MinistryCard> {
  String userMinistry;

  @override
  void initState() {
    /*final litUser = context.getSignedInUser();
    litUser.when(
      (litUser) => user = litUser,
      empty: () {},
      initializing: () {},
    );*/
    updateMinistry();
    super.initState();
  }

  updateMinistry() {
    setState(() {
      DbHelper.getUserMinistry(widget.user.uid)
          .then((value) => userMinistry = value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 70,
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ]),
            widget.title == userMinistry
                ? Center(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white10,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.orange,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        AuthHelper.saveUserMinistry(widget.user, widget.title);
                        updateMinistry();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primary,
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
