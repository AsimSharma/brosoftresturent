import 'package:brosoftresturent/utils/responsive_extension.dart';
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
    return Container(
      constraints:
          BoxConstraints(minHeight: 0.008.h(context), maxWidth: 1.0.w(context)),
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
                      Image.asset("assets/images/nepalirupees.png"),
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
    );
  }
}
