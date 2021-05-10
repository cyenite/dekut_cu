import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';

class DevotionalDetail extends StatefulWidget {
  final String title;
  final String caption;
  const DevotionalDetail(
      {Key key, @required this.title, @required this.caption})
      : super(key: key);
  @override
  _DevotionalDetailState createState() => _DevotionalDetailState();
}

class _DevotionalDetailState extends State<DevotionalDetail> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        child: const SizedBox.shrink(),
                      ),
                      color: primary,
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
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Icon(
                              Icons.bookmark_border,
                              color: Colors.white,
                              size: 30,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
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
                                SizedBox(width: 2.0),
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 2.0),
                              ],
                            ),
                            SizedBox(width: 40.0),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(height: 20.0),
                        Text(
                          widget.caption,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                              letterSpacing: 1),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
