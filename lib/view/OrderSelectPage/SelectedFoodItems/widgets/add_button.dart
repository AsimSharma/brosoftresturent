import 'dart:developer';

import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../model/remote_products.dart';
import '../../../../utils/app_style.dart';

class AddButtons extends StatelessWidget {
  const AddButtons(
      {super.key,
      required this.orderCartController,
      required this.fooditems,
      required this.tableName,
      required this.backGroundColors,
      required this.height,
      required this.width,
      this.isCustomize = false,
      this.foodQuantity = "",
      this.spicyLevel = "",
      this.addOns = ""});

  final OrDerController orderCartController;
  final FoodItems fooditems;
  final String tableName, foodQuantity, spicyLevel, addOns;
  final Color backGroundColors;
  final double height, width;
  final bool isCustomize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        log(" This is is Customize or not $isCustomize add yyyyyyyyy");
        isCustomize == true
            ? orderCartController.addCustomizeItemsInCart(
                fooditems, foodQuantity, spicyLevel, addOns, tableName)
            : orderCartController.addItemsOnCart(fooditems, tableName);
      },
      child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(
              left: 0.020.toResponsive(context),
              right: 0.020.toResponsive(context)),
          decoration: BoxDecoration(
              color: backGroundColors,
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

class AddCustomizrOrder extends StatelessWidget {
  const AddCustomizrOrder(
      {super.key,
      required this.orderCartController,
      required this.fooditems,
      required this.tableName,
      required this.backGroundColors,
      required this.height,
      required this.width,
      this.foodQuantity = "",
      this.spicyLevel = "",
      this.addOns = ""});

  final OrDerController orderCartController;
  final FoodItems fooditems;
  final String tableName, foodQuantity, spicyLevel, addOns;
  final Color backGroundColors;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        orderCartController.addCustomizeItemsInCart(
            fooditems, foodQuantity, spicyLevel, addOns, tableName);
      },
      child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(
              left: 0.020.toResponsive(context),
              right: 0.020.toResponsive(context)),
          decoration: BoxDecoration(
              color: backGroundColors,
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
