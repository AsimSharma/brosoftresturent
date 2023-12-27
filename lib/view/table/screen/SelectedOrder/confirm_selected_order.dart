import 'package:brosoftresturent/controller/order_cart_controller.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "dart:developer";

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrDerController>();
    var date = DateTime.now();
    log("ahele bihanko ${date.minute} bajyoo");
    return Scaffold(
      bottomNavigationBar: bottomCartBar(context),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 0.012.toResponsive(context),
            right: 0.012.toResponsive(context),
          ),
          child: Column(
            children: [
              headerSection(context),
              SizedBox(
                height: 0.004.h(context),
              ),
              textSections(context, "2A", 120, 102),
              const Divider(),
              SizedBox(
                height: 0.008.h(context),
              ),
              orderInfo(context),
              SizedBox(
                height: 0.008.h(context),
              ),
              SizedBox(
                height: 0.65.h(context),
                width: 1.0.w(context),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: orderController.ordercart.length,
                    itemBuilder: ((context, index) {
                      var data =
                          orderController.ordercart[index].productItems[0];
                      return Container(
                        margin:
                            EdgeInsets.only(top: 0.005.toResponsive(context)),
                        padding: EdgeInsets.all(0.005.toResponsive(context)),
                        height: 0.15.h(context),
                        width: 0.5.w(context),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 245, 239, 238),
                            boxShadow: [
                              BoxShadow(
                                  // spreadRadius: 5,
                                  blurRadius: 1,
                                  color: Colors.black,
                                  offset: Offset(0.0, 0.0005))
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //top
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 0.05.h(context),
                                        width: 0.05.w(context),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(data.veg !=
                                                        true
                                                    ? "assets/images/Non-veg Icon.png"
                                                    : "assets/images/Veg Icon.png"))),
                                      ),
                                      SizedBox(
                                        width: 0.01.w(context),
                                      ),
                                      Text(
                                        data.name,
                                        style: TextStyle(
                                            color: textColor,
                                            fontFamily: "RobotoRegular",
                                            fontWeight: FontWeight.w900,
                                            fontSize:
                                                0.015.toResponsive(context)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.05.h(context),
                                    width: 0.25.w(context),
                                    padding: EdgeInsets.all(
                                        0.0075.toResponsive(context)),
                                    decoration: const BoxDecoration(
                                        color: secondaryColors,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              child: SizedBox(
                                            height: 0.045.h(context),
                                            width: 0.035.w(context),
                                            // color: Colors.red,
                                            child: Image.asset(
                                                "assets/images/subwhite.png"),
                                          )),
                                          Text(
                                            data.quantity.toString(),
                                            style: myTextStyle(
                                                primary,
                                                0.015.toResponsive(context),
                                                "RobotoRegular"),
                                          ),
                                          InkWell(
                                              child: SizedBox(
                                            height: 0.045.h(context),
                                            width: 0.035.w(context),
                                            // color: Colors.red,
                                            child: Image.asset(
                                                "assets/images/addwhite.png"),
                                          )),
                                        ]),
                                  ),
                                ],
                              ),
                              //bottom

                              Padding(
                                padding:
                                    EdgeInsets.all(0.008.toResponsive(context)),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        border: Border.all(
                                            color: const Color(0xFF000000),
                                            width: 2),
                                      ),
                                      child: const Icon(
                                        Icons.add_rounded,
                                        color: secondaryColors,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.01.w(context),
                                    ),
                                    Text(
                                      "Add note",
                                      style: TextStyle(
                                          color: secondaryColors,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w900,
                                          fontSize:
                                              0.015.toResponsive(context)),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 0.045.h(context),
                                          width: 0.035.w(context),
                                          child: Image.asset("assets/images/"),
                                        ),
                                        Text(
                                          data.prices.toString(),
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 138, 133, 133),
                                              fontSize:
                                                  0.015.toResponsive(context),
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "RobotRegular"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
                      );
                    })),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox orderInfo(BuildContext context) {
    return SizedBox(
      height: 0.065.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Order Info",
            style: TextStyle(
                color: textColor,
                fontSize: 0.015.toResponsive(context),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w800),
          ),
          Container(
            height: 0.8.h(context),
            width: 0.45.w(context),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black45, offset: Offset(0.0, 0.05)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: Color.fromARGB(255, 245, 244, 244),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset("assets/images/timeclender.png"),
                Container(
                  child: const Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
                Text(
                  "Schedule Order",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 0.015.toResponsive(context),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container bottomCartBar(BuildContext context) {
    final orderController = Get.find<OrDerController>();
    return Container(
      height: 0.08.h(context),
      width: 1.0.w(context),
      margin: EdgeInsets.all(0.002.toResponsive(context)),
      decoration: const BoxDecoration(
          color: secondaryColors,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.05.w(context),
          ),
          //itemsrs

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      orderController.getTotalItems().toString(),
                      style: myTextStyle(
                          primary, 0.015.toResponsive(context), "Roboto"),
                    ),
                  ),
                  Text(
                    " items",
                    style: myTextStyle(
                        primary, 0.015.toResponsive(context), "Roboto"),
                  )
                ],
              ),
              SizedBox(
                width: 0.05.w(context),
              ),
              Image.asset("assets/images/vectro7.png"),
              SizedBox(
                width: 0.05.w(context),
              ),
              Row(
                children: [
                  Image.asset("assets/images/nepalirs (1).png"),
                  Obx(
                    () => Text(
                      orderController.calculateTotalPrices().toString(),
                      style: myTextStyle(
                          primary, 0.015.toResponsive(context), "Roboto"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 0.16.w(context),
          ),

          InkWell(
            onTap: () {
              Get.to(const ConfirmOrderScreen());
            },
            child: Container(
              height: 0.06.h(context),
              width: 0.35.w(context),
              decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                  "connfirm Order",
                  style: myTextStyle(
                      textColor, 0.015.toResponsive(context), "Roboto"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container headerSection(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(top: 0.001.toResponsive(context)),
      color: primary,
      height: 0.06.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              height: 0.05.h(context),
              width: 0.03.w(context),
              child: Container(
                height: 0.025.h(context),
                width: 0.02.w(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Back Icon.png"))),
              ),
            ),
          ),
          Text(
            "Confirm Order",
            style: TextStyle(
                color: textColor,
                fontSize: 0.018.toResponsive(context),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w900),
          ),
          Container(
            height: 0.06.h(context),
            width: 0.06.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/notification.png"))),
          ),
        ],
      ),
    );
  }

  Container textSections(BuildContext context, String tableName,
      int guestNumber, int orderNumber) {
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
                guestNumber.toString(),
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
                orderNumber.toString(),
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
