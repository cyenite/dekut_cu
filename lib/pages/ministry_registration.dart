import 'package:dekut_cu/widget/ministry_card.dart';
import 'package:flutter/material.dart';

class MinistryRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ministries')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MinistryCard(
                title: 'Music Ministry',
                description: 'Description',
              ),
              MinistryCard(title: 'Ushering', description: 'Description'),
              MinistryCard(
                title: 'Publicity',
                description: 'Description',
              ),
            ],
          )),
    );
  }
}
