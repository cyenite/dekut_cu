import 'package:dekut_cu/models/event.dart';
import 'package:dekut_cu/pages/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomEventCard extends StatelessWidget {
  final Event event;

  CustomEventCard({this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(event.imageUrl);
        Get.to(EventDetailPage(
          event: event,
        ));
      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      event.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
              Text(
                event.date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
