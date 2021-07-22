import 'package:flutter/material.dart';

class CustomEventCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  CustomEventCard({this.date, this.description, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ]),
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
