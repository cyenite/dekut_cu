import 'package:dekut_cu/theme/colors.dart';
import 'package:flutter/material.dart';

class UserContainer extends StatelessWidget {
  final Size size;
  final String role;
  final String email;
  final String date;
  final String name;

  UserContainer(
      {@required this.size,
      @required this.role,
      @required this.email,
      @required this.date,
      @required this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                          Icons.supervised_user_circle,
                          size: 30,
                        )),
                      ),
                      SizedBox(width: 15),
                      Container(
                        width: (size.width - 90) * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name != null ? name : "null",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: black,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              email != null ? email : "null",
                              style: TextStyle(
                                  fontSize: 11,
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
                        role,
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
