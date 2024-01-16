import 'dart:developer';

import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../model/remote_products.dart';
import '../../../../utils/app_style.dart';

class IncDecButtons extends StatelessWidget {
  const IncDecButtons(
      {super.key,
      required this.orderCartController,
      required this.fooditems,
      required this.backGroungColor,
      this.isCustomize = false});

  final OrDerController orderCartController;
  final FoodItems fooditems;
  final Color backGroungColor;
  final bool isCustomize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 0.025.toResponsive(context),
          right: 0.025.toResponsive(context)),
      height: 0.05.h(context),
      width: 0.3.w(context),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backGroungColor,
          borderRadius:
              BorderRadius.all(Radius.circular(0.015.toResponsive(context)))),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  log(" This is is Customize or not $isCustomize dec");
                  isCustomize == true
                      ? orderCartController.decraseCustomizeQantity(fooditems)
                      : orderCartController.decFoodQuanity(fooditems);
                },
                child: SizedBox(
                  height: 1.0.h(context),
                  width: 0.073.w(context),
                  child: Image.asset(
                      "assets/images/${backGroungColor == Colors.white ? "subtract icon.png" : "subwhite.png"}"),
                )),
            Text(
              isCustomize == true
                  ? orderCartController
                      .findCustomizeQuantity(fooditems.fid)
                      .toString()
                  : orderCartController.findQuantity(fooditems.fid).toString(),
              style: TextStyle(
                  color: backGroungColor == Colors.white
                      ? secondaryColors
                      : primary,
                  fontSize: 0.013.toResponsive(context),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto"),
            ),
            InkWell(
                onTap: () {
                  log(" This is is Customize or not $isCustomize");
                  isCustomize == true
                      ? orderCartController.increaseCustomizeQantity(fooditems)
                      : orderCartController.increaseFoodQuanity(fooditems);
                },
                child: SizedBox(
                  height: 1.0.h(context),
                  width: 0.073.w(context),
                  child: Image.asset(
                      "assets/images/${backGroungColor == Colors.white ? "Add icon.png" : "addwhite.png"}"),
                )),
          ]),
    );
  }
}
