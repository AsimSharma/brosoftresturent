import 'package:brosoftresturent/controller/order_cart_controller.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import '../../utils/app_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrDerController());
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 0.012.toResponsive(context),
              right: 0.012.toResponsive(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logoHeader(context),
                orderHistory(context),
                SizedBox(
                  height: 0.015.h(context),
                ),
                searchBar(context),
                SizedBox(
                  height: 0.015.h(context),
                ),
                SizedBox(
                  height: 0.625.h(context),
                  width: 1.0.w(context),
                  child: ListView.builder(
                      itemCount: orderController.ordercart.length,
                      itemBuilder: (context, index1) {
                        log(orderController.ordercart.length.toString());
                        return Container(
                          height: 0.25.h(context),
                          width: 1.0.w(context),
                          margin: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 0.25.h(context),
                                width: 1.0.w(context),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: orderController
                                        .ordercart[index1].productItems.length,
                                    itemBuilder: (context, index2) {
                                      log(orderController
                                          .ordercart[index1].productItems.length
                                          .toString());
                                      var data = orderController
                                          .ordercart[index1]
                                          .productItems[index2];

                                      var dataa =
                                          orderController.ordercart[index1];

                                      return SizedBox(
                                        height: 0.25.h(context),
                                        width: 1.0.w(context),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 0.15.h(context),
                                              width: 1.0.w(context),
                                              color: secondaryColors,
                                              child: Row(
                                                children: [
                                                  Text(dataa.tableName),
                                                  Text(
                                                      dataa.orderNo.toString()),
                                                ],
                                              ),
                                            ),
                                            Text(data.name),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            )),
      ),
    );
  }

  Container orderHistory(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0058.toResponsive(context)),
      height: 0.045.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Order",
            style: TextStyle(
                color: textColor,
                fontFamily: "RobotoRegular",
                fontWeight: FontWeight.w600,
                fontSize: 0.017.toResponsive(context)),
          ),
          Container(
            height: 0.9.h(context),
            width: 0.13.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/orderhistory.png"))),
          )
        ],
      ),
    );
  }

  Container logoHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.01.toResponsive(context)),
      color: primary,
      height: 0.1.h(context),
      width: 1.0.w(context),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 0.08.h(context),
                  width: 0.2.w(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo_images.png"))),
                ),
                SizedBox(
                  width: 0.0040.w(context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      logoText,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 0.019.toResponsive(context),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      address,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 0.012.toResponsive(context),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ),
                SizedBox(
                  width: 0.0030.w(context),
                ),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/notification.png"))
          ]),
    );
  }

  Container searchBar(BuildContext context) => Container(
        height: 0.065.h(context),
        width: 1.0.w(context),
        margin: EdgeInsets.only(left: 0.0055.toResponsive(context)),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.2,
            style: BorderStyle.solid,
            color: textColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 0.06.h(context),
              width: 0.2.w(context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/searchicons.png"),
                ),
              ),
            ),
            SizedBox(
              height: 0.89.h(context),
              width: 0.65.w(context),
              child: Padding(
                padding: EdgeInsets.all(0.0037.toResponsive(context)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by order number",
                    hintStyle: TextStyle(
                        color: textColor,
                        fontSize: 0.014.toResponsive(context),
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w900),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        ),
      );
}
