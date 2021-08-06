import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/models/inventory.dart';
import 'package:dekut_cu/services/database_helper.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:dekut_cu/widget/inventory_card.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final GlobalKey<FormState> _reqFormKey2 = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
        actions: [
          GestureDetector(
            onTap: () {},
            child: GestureDetector(
              onTap: () {
                addInventoryDialog();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("inventory")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot != null) {
                    final docs = snapshot.data.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final inventory = docs[index].data();
                        print(inventory);
                        return InventoryCard(
                          inventory: Inventory(
                              name: inventory['name'],
                              quantity: inventory['quantity'],
                              state: inventory['state']),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addInventoryDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _reqFormKey2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Name required";
                        },
                        decoration: InputDecoration(
                          hintText: "Name of inventory item",
                        ),
                      ),
                      TextFormField(
                        controller: _stateController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "State required";
                        },
                        decoration: InputDecoration(
                          hintText: "State(new/damaged/under repair)",
                        ),
                      ),
                      TextFormField(
                        controller: _quantityController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Quantity";
                        },
                        decoration: InputDecoration(
                          hintText: "Number of items",
                        ),
                      ),
                    ],
                  )),
              title: Text('Add Inventory'),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 13.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child:
                        Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () async {
                    if (_nameController.text != null &&
                        _stateController.text != null) {
                      await DbHelper.addInventory(Inventory(
                          name: _nameController.text,
                          state: _stateController.text,
                          quantity: _quantityController.text));
                      _nameController.clear();
                      _stateController.clear();
                      _quantityController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}
