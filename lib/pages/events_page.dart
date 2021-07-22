import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/widget/custom_event_card.dart';
import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("events").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot != null) {
              final docs = snapshot.data.docs;
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final event = docs[index].data();
                  print(event);
                  return CustomEventCard(
                    title: event['title'],
                    description: event['description'],
                    date: event['date'],
                  );
                },
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
