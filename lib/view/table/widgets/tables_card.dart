import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../model/tables_model.dart';
import '../../../utils/app_style.dart';

class TablesCard extends StatelessWidget {
  const TablesCard({
    super.key,
    required this.tableItems,
  });

  final TableItem tableItems;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tableItems.reserved == true ? reservedColor : primary,
      margin: EdgeInsets.all(0.0051.toResponsive(context)),
      child: Stack(children: [
        Positioned(
            top: 0.010.h(context),
            right: 0.02.h(context),
            child: Text(
              tableItems.tableName,
              style: TextStyle(
                  color: secondaryColors,
                  fontSize: 0.023.toResponsive(context),
                  fontWeight: FontWeight.w900,
                  fontFamily: "Roboto"),
            )),
        Positioned(
          bottom: 0.01.h(context),
          child: Row(children: [
            SizedBox(
              height: 0.03.w(context),
              width: 0.05.w(context),
              child: Image.asset(
                "assets/images/imageperson.png",
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
            Row(
              children: [
                Text(
                  "${tableItems.seat} ",
                  style: myTextStyle(
                      secondaryColors, 0.017.toResponsive(context), "Roboto"),
                ),
                Text(
                  "people",
                  style: myTextStyle(
                      textColor, 0.013.toResponsive(context), "Nunito"),
                )
              ],
            )
          ]),
        ),
      ]),
    );
  }
}
