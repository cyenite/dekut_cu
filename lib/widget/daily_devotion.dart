import 'package:dekut_cu/pages/study_detail.dart';
import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyDevotion extends StatelessWidget {
  final Size size;
  final String verse;
  final String teaching;
  final String title;
  final String date;

  DailyDevotion(
      {@required this.size,
      @required this.verse,
      @required this.title,
      @required this.teaching,
      @required this.date});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(StudyDetail(
          verse: verse,
          teaching: teaching,
          title: title,
        ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.transparent,
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
                          child: Icon(
                            Icons.book_outlined,
                            color: Colors.blue,
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
                              title,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              date == null ? 'null' : date,
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
                        verse,
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
      ),
    );
  }
}
