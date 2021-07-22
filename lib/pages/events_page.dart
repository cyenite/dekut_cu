import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/models/event.dart';
import 'package:dekut_cu/widget/custom_event_card.dart';
import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("events").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot != null) {
              final docs = snapshot.data.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final event = docs[index].data();
                  print(event);
                  return CustomEventCard(event: Event.fromSnapshot(event));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
