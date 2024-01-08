import 'dart:developer';

import 'package:brosoftresturent/controller/order_cart_controller.dart';
import 'package:brosoftresturent/controller/remote_order_controller.dart';

import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/remote_productcontroller.dart';
import '../../../model/remote_order_models.dart';
import '../widgets/header_app_bar.dart';
import '../order_placed_screen.dart';
import '../widgets/table_order_info.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen(
      {super.key,
      required this.tableName,
      required this.totalGuest,
      required this.orderNo,
      required this.isAddOrders,
      required this.orderId});
  final String tableName;
  final int totalGuest;
  final int orderNo;
  final bool isAddOrders;
  final String orderId;

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final orderController = Get.find<OrDerController>();
  final productController = Get.find<RemoteProductCtrl>();

  final remoteOrderCtrl = Get.put(RemoteOrderCtrl());
  String noteText = "";
  bool addNote = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomCartBar(
          context,
          widget.tableName,
          widget.totalGuest,
          widget.orderNo,
          widget.isAddOrders,
          widget.orderId),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 0.012.toResponsive(context),
            right: 0.012.toResponsive(context),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeadeAppBar(
                  titleName: "Confirm Order",
                  onPressed: () {
                    Get.to(() => const HomeScreen());
                    orderController.clearCart();
                  },
                ),
                SizedBox(
                  height: 0.004.h(context),
                ),
                TableOrderInfo(
                    tableName: widget.tableName,
                    totalGuest: widget.totalGuest,
                    orderNo: widget.orderNo),
                const Divider(),
                SizedBox(
                  height: 0.008.h(context),
                ),
                orderInfo(context),
                SizedBox(
                  height: 0.008.h(context),
                ),
                Obx(() => confirmOrderList(
                    context, orderController, productController)),
                Obx(() => grandTotaL(context, orderController))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container grandTotaL(BuildContext context, OrDerController orderController) {
    return Container(
      height: 0.17.h(context),
      width: 1.0.w(context),
      padding: const EdgeInsets.all(10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //left
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 0.06.h(context),
                padding: EdgeInsets.all(0.010.toResponsive(context)),
                decoration: const BoxDecoration(
                    color: btnBghColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border:
                          Border.all(color: const Color(0xFF000000), width: 2),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: secondaryColors,
                      size: 15,
                    ),
                  ),
                  SizedBox(
                    width: 0.016.w(context),
                  ),
                  Text(
                    "Add More Item",
                    style: TextStyle(
                        color: textColor,
                        fontFamily: "RobotoRegular",
                        fontWeight: FontWeight.w900,
                        fontSize: 0.014.toResponsive(context)),
                  )
                ]),
              ),
            ),
            //right
            SizedBox(
              // width: 0.6.w(context),
              height: 1.0.h(context),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textData(
                        context,
                        "Total",
                        orderController.calculateTotalPrices(),
                        secondaryColors,
                        "nepalirupees.png",
                        "Roboto",
                        FontWeight.w500),
                    textData(
                        context,
                        "Service Tax",
                        orderController.getServicTax(),
                        Colors.grey,
                        "nepalirupees.png",
                        "Roboto",
                        FontWeight.w400),
                    textData(
                        context,
                        "Vat 13%",
                        orderController.getVatTax(),
                        Colors.grey,
                        "nepalirupees.png",
                        "Roboto",
                        FontWeight.w400),
                    textData(
                        context,
                        "Grand Total",
                        orderController.grandTotalPrices(),
                        secondaryColors,
                        "paisanilo.png",
                        "Roboto",
                        FontWeight.w900),
                  ]),
            )
          ]),
    );
  }

  Row textData(BuildContext context, String title, double pricesTotal,
      Color collors, String images, String fontFamily, FontWeight fontWeight) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: collors,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
              fontSize: 0.015.toResponsive(context)),
        ),
        SizedBox(
          width: 0.03.w(context),
        ),
        Row(
          children: [
            Image.asset(
              ("assets/images/$images"),
            ),
            Text(
              pricesTotal.toString(),
              style: TextStyle(
                  color: collors,
                  fontFamily: fontFamily,
                  fontWeight: fontWeight,
                  fontSize: 0.015.toResponsive(context)),
            ),
          ],
        )
      ],
    );
  }

  SizedBox confirmOrderList(BuildContext context,
      OrDerController orderController, RemoteProductCtrl productController) {
    return SizedBox(
      height: 0.45.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: orderController.addItems.length,
          itemBuilder: ((context, index) {
            var data = orderController.addItems[index];

            return Visibility(
              visible: data.quantity > 0,
              child: Container(
                margin: EdgeInsets.only(top: 0.005.toResponsive(context)),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 0.04.h(context),
                                width: 0.04.w(context),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(data.isVeg != true
                                            ? "assets/images/Non-veg Icon.png"
                                            : "assets/images/Veg Icon.png"))),
                              ),
                              SizedBox(
                                width: 0.01.w(context),
                              ),
                              Text(
                                data.foodName,
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: "RobotoRegular",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 0.014.toResponsive(context)),
                              ),
                            ],
                          ),
                          Container(
                            height: 0.05.h(context),
                            width: 0.25.w(context),
                            padding:
                                EdgeInsets.all(0.0075.toResponsive(context)),
                            decoration: const BoxDecoration(
                                color: secondaryColors,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        // productController
                                        orderController
                                            .decraseCartQuantity(data);
                                      },
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
                                      onTap: () {
                                        orderController
                                            .increaseCartQuantity(data);
                                      },
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
                        padding: EdgeInsets.all(0.008.toResponsive(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //checkedCondations

                            data.isAdded == false
                                ? InkWell(
                                    onTap: () {
                                      orderController.isAddedNote(data);
                                      log("is Added ${data.isAdded}");
                                    },
                                    child: Container(
                                      height: 0.05.h(context),
                                      width: 0.35.w(context),
                                      // color: Colors.red,
                                      padding: EdgeInsets.all(
                                          0.008.toResponsive(context)),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF000000),
                                                  width: 2),
                                            ),
                                            child: const Icon(
                                              Icons.add_rounded,
                                              color: secondaryColors,
                                              size: 15,
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
                                                fontSize: 0.014
                                                    .toResponsive(context)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 0.05.h(context),
                                    width: 0.55.w(context),
                                    decoration: BoxDecoration(
                                        color: btnBghColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                          color: secondaryColors,
                                          width: 1.0,
                                        )),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 0.8.h(context),
                                          width: 0.41.w(context),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: data.note ?? "",
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15,
                                                      bottom: 11,
                                                      top: 11,
                                                      right: 15),
                                              disabledBorder: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                noteText = value;
                                                log(" your Note: $noteText");
                                                orderController.updateNote(
                                                    noteText, data);
                                              });
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              orderController.isAddedNote(data);
                                              log("is Added ${data.isAdded}");
                                            },
                                            icon: const Icon(
                                                Icons.cancel_outlined))
                                      ],
                                    ),
                                  ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 0.045.h(context),
                                  width: 0.035.w(context),
                                  child: Image.asset(
                                      "assets/images/nepalirupees.png"),
                                ),
                                Text(
                                  orderController
                                      .calculateIndivisualPrices(data)
                                      .toString(),
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 138, 133, 133),
                                      fontSize: 0.014.toResponsive(context),
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "RobotRegular"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            );
          })),
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

  Container bottomCartBar(BuildContext context, String tableName,
      int totalGuest, int orderNo, bool isAddedOrders, String orderId) {
    final orderController = Get.find<OrDerController>();
    final remoteOrderController = Get.find<RemoteOrderCtrl>();
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
                      orderController.grandTotalPrices().toString(),
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
              RemoteOrderModel newOrder = RemoteOrderModel(
                  orderNo: widget.orderNo,
                  totalGuest: widget.totalGuest,
                  tableName: tableName,
                  time: DateTime.now(),
                  scheduleFor: DateTime.now(),
                  isCompleted: false,
                  orders: orderController.addItems,
                  addedOrders: [],
                  id: "${widget.orderNo}");

              isAddedOrders == false
                  ? remoteOrderController.addOrders(newOrder)
                  : remoteOrderCtrl.updateAddOrders(
                      orderId, orderController.addItems);

              Get.to(() => OrderPlacedSucess(
                    orderNo: widget.orderNo,
                  ));
            },
            child: Container(
              height: 0.06.h(context),
              width: 0.3.w(context),
              decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                  "confirm Order",
                  style: myTextStyle(
                      textColor, 0.012.toResponsive(context), "Roboto"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
