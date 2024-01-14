import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../model/remote_products.dart';
import '../../../../utils/app_style.dart';

class AddButtons extends StatelessWidget {
  const AddButtons({
    super.key,
    required this.orderCartController,
    required this.fooditems,
    required this.tableName,
  });

  final OrDerController orderCartController;
  final FoodItems fooditems;
  final String tableName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        orderCartController.addItemsOnCart(fooditems, tableName);
      },
      child: Container(
          padding: EdgeInsets.only(
              left: 0.020.toResponsive(context),
              right: 0.020.toResponsive(context)),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: secondaryColors, width: 2)),
          margin: EdgeInsets.only(
              left: 0.04.toResponsive(context),
              right: 0.04.toResponsive(context)),
          alignment: Alignment.center,
          child: Text(
            "Add",
            style:
                myTextStyle(textColor, 0.015.toResponsive(context), "Roboto"),
          )),
    );
  }
}
