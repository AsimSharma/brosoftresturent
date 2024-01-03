import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';

class TableOrderInfo extends StatelessWidget {
  const TableOrderInfo({
    super.key,
    required this.tableName,
    required this.totalGuest,
    required this.orderNo,
  });

  final String tableName;
  final int totalGuest;
  final int orderNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.05.h(context),
      margin: EdgeInsets.only(left: 0.0015.toResponsive(context)),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Table ",
                style: myTextStyle(
                    textColor, 0.013.toResponsive(context), "Roboto"),
              ),
              Text(
                tableName,
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.015.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Guest ",
                style: myTextStyle(
                    textColor, 0.013.toResponsive(context), "Roboto"),
              ),
              Text(
                totalGuest.toString(),
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.015.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Order No",
                style: myTextStyle(
                    textColor, 0.013.toResponsive(context), "Roboto"),
              ),
              Text(
                orderNo.toString(),
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.015.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
