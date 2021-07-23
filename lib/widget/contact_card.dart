import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'data',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: primary,
            ),
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }
}
