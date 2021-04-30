import 'package:dekut_cu/json/daily_json.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';

class DailyDevotion extends StatelessWidget {
  final Size size;
  final int index;
  bool selected;
  DailyDevotion(
      {@required this.size, @required this.index, @required this.selected});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: selected ? Colors.pink[100] : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: (size.width - 40) * 0.7,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grey.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Image.asset(
                          daily[index]['icon'],
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: (size.width - 90) * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            daily[index]['title'],
                            style: TextStyle(
                                fontSize: 15,
                                color: black,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            daily[index]['date'],
                            style: TextStyle(
                                fontSize: 12,
                                color: black.withOpacity(0.5),
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: (size.width - 40) * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      daily[index]['book'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.green),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 65, top: 8),
          child: Divider(
            thickness: 0.8,
          ),
        )
      ],
    );
  }
}
