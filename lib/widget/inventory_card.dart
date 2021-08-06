import 'package:dekut_cu/models/inventory.dart';
import 'package:flutter/material.dart';

class InventoryCard extends StatelessWidget {
  final Inventory inventory;

  InventoryCard({@required this.inventory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      inventory.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'State: ${inventory.state}',
                      maxLines: 4,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ]),
              Text(
                'Quantity: ${inventory.quantity}',
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
