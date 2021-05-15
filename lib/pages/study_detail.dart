import 'package:flutter/material.dart';

class StudyDetail extends StatefulWidget {
  final String title;
  final String verse;
  final String teaching;
  const StudyDetail(
      {Key key,
      @required this.title,
      @required this.teaching,
      @required this.verse})
      : super(key: key);
  @override
  _StudyDetailState createState() => _StudyDetailState();
}

class _StudyDetailState extends State<StudyDetail> {
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
                      color: Colors.black26,
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
                            Text(
                              widget.verse,
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.grey),
                            ),
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
                          widget.teaching,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
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
