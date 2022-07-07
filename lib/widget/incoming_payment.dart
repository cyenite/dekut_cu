import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class IncomingPayment extends StatelessWidget {
  final String phone;
  final int amount;
  final String category;
  final bool confirmed;

  IncomingPayment(
      {@required this.phone,
      @required this.amount,
      @required this.category,
      @required this.confirmed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            phone,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      amount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.green),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),*/
        BannerListTile(
          bannerText: confirmed ? "Paid" : "Pending",
          bannerColor: confirmed ? Colors.green : Colors.red,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          title: Text(
            category,
            style: TextStyle(
                fontSize: 18, color: Colors.green, fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            phone,
            style: TextStyle(
                fontSize: 14,
                color: black.withOpacity(0.5),
                fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            amount.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.green),
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
