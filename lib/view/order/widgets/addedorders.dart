import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/widgets/shared/nepalirs.dart';
import 'package:flutter/material.dart';

import '../../../model/remote_order_models.dart';
import '../../../utils/app_style.dart';

class AddedOrdersList extends StatelessWidget {
  const AddedOrdersList({
    super.key,
    required this.filterValue,
    required this.index1,
  });

  final List<RemoteOrderModel> filterValue;
  final int index1;

  @override
  Widget build(BuildContext context) {
    int time = DateTime.now()
        .difference(filterValue[index1].addedOrders[0].addedTime)
        .inMinutes;
    return Column(
      children: [
        AddedItemHeaderInfo(
            filterValue: filterValue, index1: index1, time: time),
        Container(
          constraints: BoxConstraints(
              minHeight: 0.008.h(context), maxWidth: 1.0.w(context)),
          // padding: EdgeInsets.all(0.005.toResponsive(context)),
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: filterValue[index1].addedOrders.length ?? 1,
              itemBuilder: (context, index2) {
                var listdata = filterValue[index1].addedOrders[index2];

                return Container(
                  height: 0.08.h(context),
                  width: 1.0.w(context),
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: 0.0055.toResponsive(context)),
                  margin: EdgeInsets.only(top: 0.001.toResponsive(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            listdata.quantity.toString() ?? "",
                            style: TextStyle(
                                color: textColor,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                fontSize: 0.013.toResponsive(context)),
                          ),
                          SizedBox(
                            width: 0.01.w(context),
                          ),
                          Text(
                            listdata.foodName ?? "",
                            style: TextStyle(
                                color: textColor,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                fontSize: 0.013.toResponsive(context)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const NepaliRSb(),
                          SizedBox(
                            width: 0.001.w(context),
                          ),
                          Text(
                            listdata.price.toString() ?? "",
                            style: TextStyle(
                                color: textColor,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                fontSize: 0.013.toResponsive(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class AddedItemHeaderInfo extends StatelessWidget {
  const AddedItemHeaderInfo({
    super.key,
    required this.filterValue,
    required this.index1,
    required this.time,
  });

  final List<RemoteOrderModel> filterValue;
  final int index1;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${filterValue[index1].addedOrders.length} item Added",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: "Nunito",
              fontSize: 0.012.toResponsive(context),
              color: Colors.red),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " OrderNo ${(filterValue[index1].orderNo)}",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: "Nunito",
                  fontSize: 0.012.toResponsive(context),
                  color: Colors.red),
            ),
            SizedBox(
              width: 0.020.w(context),
            ),
            Text(
              "$time m ago",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: "Nunito",
                  fontSize: 0.012.toResponsive(context),
                  color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
