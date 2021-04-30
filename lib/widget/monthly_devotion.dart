import 'package:dekut_cu/json/devotionals_json.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';

class MonthlyDevotion extends StatelessWidget {
  final int index;
  final Size size;
  final bool selected;
  MonthlyDevotion(
      {@required this.size, @required this.index, @required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: selected ? grey : white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthly_devotions[index]['month'],
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color:
                        selected ? white : Color(0xff67727d).withOpacity(0.6)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        monthly_devotions[index]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: selected ? white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          monthly_devotions[index]['completion_percentage'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: selected
                                  ? white
                                  : Color(0xff67727d).withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Container(
                    width: (size.width - 40),
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selected
                            ? white
                            : Color(0xff67727d).withOpacity(0.1)),
                  ),
                  Container(
                    width: (size.width - 40) *
                        monthly_devotions[index]['percentage'],
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: monthly_devotions[index]['color']),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
