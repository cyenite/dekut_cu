import 'package:cached_network_image/cached_network_image.dart';
import 'package:dekut_cu/models/event.dart';
import 'package:dekut_cu/services/database_helper.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({@required this.event});

  @override
  Widget build(BuildContext context) {
    User user;

    //final litUser = context.getSignedInUser();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      child: event.imageUrl != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Image.network(
                                event.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.0),
                            topRight: Radius.circular(60.0)),
                      ),
                      child: SizedBox(width: 1),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await DbHelper.registerForEvent(
                                  event.title, user);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: primary,
                              ),
                              child: Text(
                                'Attend',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ), /*IconButton(
                                icon: Icon(
                                  Icons.bookmark_border,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),*/
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event.title,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /* Text(
                          "⭐ 4.5",
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),*/
                        SizedBox(width: 20.0),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              event.date,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16.0),
                            )
                          ],
                        ),
                        SizedBox(width: 20.0),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(event.imageUrl),
                          radius: 28.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Dekut CU',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.8),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      event.description,
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.grey, letterSpacing: 1),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
