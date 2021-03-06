import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';

class AnalyticContainer extends StatelessWidget {
  final Color color;
  final String label;
  final String detail;
  AnalyticContainer(
      {@required this.color,
      this.detail,
      @required this.label});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width - 60) / 2,
      height: 170,
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
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Center(
                  child: Icon(
                Icons.analytics,
                color: white,
              )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  detail!=null? detail : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
