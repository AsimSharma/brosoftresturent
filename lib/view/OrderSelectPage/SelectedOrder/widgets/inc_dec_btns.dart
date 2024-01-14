import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../model/remote_products.dart';
import '../../../../utils/app_style.dart';

class IncDecButtons extends StatelessWidget {
  const IncDecButtons({
    super.key,
    required this.orderCartController,
    required this.fooditems,
  });

  final OrDerController orderCartController;
  final FoodItems fooditems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 0.025.toResponsive(context),
          right: 0.025.toResponsive(context)),
      height: 0.05.h(context),
      width: 0.3.w(context),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: secondaryColors,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  orderCartController.decFoodQuanity(fooditems);
                },
                child: SizedBox(
                  height: 1.0.h(context),
                  width: 0.073.w(context),
                  child: Image.asset("assets/images/subwhite.png"),
                )),
            Text(
              orderCartController.findQuantity(fooditems.fid).toString(),
              style: TextStyle(
                  color: primary,
                  fontSize: 0.013.toResponsive(context),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto"),
            ),
            InkWell(
                onTap: () {
                  orderCartController.increaseFoodQuanity(fooditems);
                },
                child: SizedBox(
                  height: 1.0.h(context),
                  width: 0.073.w(context),
                  child: Image.asset("assets/images/addwhite.png"),
                )),
          ]),
    );
  }
}
