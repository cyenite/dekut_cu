import 'package:dekut_cu/config/palette.dart';
import 'package:dekut_cu/pages/devotional_detail.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyDevotion extends StatelessWidget {
  //final int index;
  final Size size;
  final bool selected;
  final String title;
  final String teaching;
  final String month;
  MonthlyDevotion(
      {@required this.size,
      @required this.month,
      @required this.selected,
      @required this.title,
      @required this.teaching});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DevotionalDetail(title: title, caption: teaching));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: white,
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
                  month,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Palette.darkOrange,
                  ),
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
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            '0%',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.blue.withOpacity(0.6)),
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
                          color: Palette.lightBlue),
                    ),
                    Container(
                      width: (size.width - 40) * 0,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Palette.darkBlue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
