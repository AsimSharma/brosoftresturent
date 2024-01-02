import 'package:brosoftresturent/controller/remote_order_controller.dart';
import 'package:brosoftresturent/model/remote_order_models.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import '../../utils/app_style.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final remoteOrderCtrl = Get.put(RemoteOrderCtrl());

  int btnTapIndex = 0;

  @override
  void initState() {
    remoteOrderCtrl.getHistoryOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderController = Get.put(OrDerController());
    return Scaffold(
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

                  //orderHistorylistView
                  btnTapIndex == 0
                      ? Obx(
                          () => SizedBox(
                            height: 0.625.h(context),
                            width: 1.0.w(context),
                            child: ListView.builder(
                                itemCount:
                                    remoteOrderCtrl.remoteOrderList.length,
                                itemBuilder: (context, index1) {
                                  var orderData =
                                      remoteOrderCtrl.remoteOrderList[index1];
                                  return Visibility(
                                    key: UniqueKey(),
                                    visible: remoteOrderCtrl
                                                .remoteOrderList[index1]
                                                .isCompleted ==
                                            false ??
                                        false,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(11)),
                                          border: Border.all(
                                              color: secondaryColors,
                                              width: 2.0)),
                                      margin: EdgeInsets.only(
                                          top: 0.01.toResponsive(context)),
                                      child: Column(
                                        children: [
                                          //toheader
                                          topHeader(
                                              context, orderData, btnTapIndex),
                                          // OrderSItems listItems
                                          Container(
                                            height: 0.25.h(context),
                                            width: 1.0.w(context),
                                            // color: Colors.red,
                                            padding: EdgeInsets.all(
                                                0.005.toResponsive(context)),
                                            child: ListView.builder(
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: remoteOrderCtrl
                                                    .remoteOrderList[index1]
                                                    .orders
                                                    .length,
                                                itemBuilder: (context, index2) {
                                                  var orderData =
                                                      remoteOrderCtrl
                                                          .remoteOrderList[
                                                              index1]
                                                          .orders[index2];
                                                  return Container(
                                                    height: 0.1.h(context),
                                                    width: 1.0.w(context),
                                                    // color: Colors.green,
                                                    margin: EdgeInsets.only(
                                                        top: 0.001.toResponsive(
                                                            context)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${orderData.price ?? 0}",
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 0.013
                                                                      .toResponsive(
                                                                          context)),
                                                            ),
                                                            SizedBox(
                                                              width: 0.01
                                                                  .w(context),
                                                            ),
                                                            Text(
                                                              orderData
                                                                      .foodName ??
                                                                  "No Food is heare ",
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 0.013
                                                                      .toResponsive(
                                                                          context)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/nepalirupees.png"),
                                                            SizedBox(
                                                              width: 0.001
                                                                  .w(context),
                                                            ),
                                                            Text(
                                                              "${(orderData.quantity ?? 0) * (orderData.price ?? 0)}",
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 0.013
                                                                      .toResponsive(
                                                                          context)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),

                                          const Divider(
                                            color: secondaryColors,
                                          ),

                                          addDeleBtns(
                                              context,
                                              btnTapIndex,
                                              remoteOrderCtrl
                                                      .remoteOrderList[index1]
                                                      .id ??
                                                  "120")
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Obx(
                          () => SizedBox(
                            height: 0.625.h(context),
                            width: 1.0.w(context),
                            child: ListView.builder(
                                itemCount:
                                    remoteOrderCtrl.remoteOrderList.length,
                                itemBuilder: (context, index1) {
                                  var orderData =
                                      remoteOrderCtrl.remoteOrderList[index1];
                                  return Visibility(
                                    key: UniqueKey(),
                                    visible: remoteOrderCtrl
                                        .remoteOrderList[index1].isCompleted,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(11)),
                                          border: Border.all(
                                              color: secondaryColors,
                                              width: 2.0)),
                                      margin: EdgeInsets.only(
                                          top: 0.01.toResponsive(context)),
                                      child: Column(
                                        children: [
                                          //toheader
                                          topHeader(
                                              context, orderData, btnTapIndex),
                                          // OrderSItems listItems
                                          Container(
                                            height: 0.25.h(context),
                                            width: 1.0.w(context),
                                            // color: Colors.red,
                                            padding: EdgeInsets.all(
                                                0.005.toResponsive(context)),
                                            child: ListView.builder(
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: remoteOrderCtrl
                                                    .remoteOrderList[index1]
                                                    .orders
                                                    .length,
                                                itemBuilder: (context, index2) {
                                                  var orderData =
                                                      remoteOrderCtrl
                                                          .remoteOrderList[
                                                              index1]
                                                          .orders[index2];
                                                  return Container(
                                                    height: 0.1.h(context),
                                                    width: 1.0.w(context),
                                                    // color: Colors.green,
                                                    margin: EdgeInsets.only(
                                                        top: 0.001.toResponsive(
                                                            context)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${orderData.price ?? 0}",
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 0.013
                                                                      .toResponsive(
                                                                          context)),
                                                            ),
                                                            SizedBox(
                                                              width: 0.01
                                                                  .w(context),
                                                            ),
                                                            Text(
                                                              orderData
                                                                      .foodName ??
                                                                  "No Food is heare ",
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 0.013
                                                                      .toResponsive(
                                                                          context)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/nepalirupees.png"),
                                                            SizedBox(
                                                              width: 0.001
                                                                  .w(context),
                                                            ),
                                                            Text(
                                                              "${(orderData.quantity ?? 0) * (orderData.price ?? 0)}",
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 0.013
                                                                      .toResponsive(
                                                                          context)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),

                                          const Divider(
                                            color: secondaryColors,
                                          ),

                                          addDeleBtns(
                                              context,
                                              btnTapIndex,
                                              remoteOrderCtrl
                                                      .remoteOrderList[index1]
                                                      .id ??
                                                  "120")
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                ],
              ),
            )),
      ),
    );
  }

  Container addDeleBtns(BuildContext context, int btnTapIndex, String id) {
    return Container(
        height: 0.09.h(context),
        width: 1.0.w(context),
        padding: EdgeInsets.symmetric(horizontal: 0.0015.toResponsive(context)),
        child: btnTapIndex == 0
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //left
                Row(
                  children: [
                    Container(
                        height: 0.06.h(context),
                        width: 0.03.h(context),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/cance_icons.png")))),
                    SizedBox(width: 0.005.w(context)),
                    InkWell(
                      onTap: () {
                        // remoteOrderCtrl.isLoading == true.obs
                        //     ? const CircularProgressIndicator(
                        //         color: Colors.blue,
                        //       )
                        //     : remoteOrderCtrl.cancelById(id);
                      },
                      child: Text(
                        "Cancle Order",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 0.015.toResponsive(context)),
                      ),
                    )
                  ],
                ),
                //right
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColors,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                            color: const Color(0xFF000000), width: 2),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: primary,
                        size: 15,
                      ),
                    ),
                    SizedBox(width: 0.005.w(context)),
                    InkWell(
                      onTap: () {
                        // Get.to(() => const SelectedOrder(
                        //       tablename: "",
                        //       totalGuest: 0,
                        //       oderNo: 0,
                        //     ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => SelectedOrder(
                        //           tablename: "",
                        //           totalGuest: 0,
                        //           oderNo: 0,
                        //         )));
                      },
                      child: Text(
                        "Add Order",
                        style: TextStyle(
                            color: secondaryColors,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 0.015.toResponsive(context)),
                      ),
                    )
                  ],
                )
              ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order Complets",
                    style: TextStyle(
                        color: textColor,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        fontSize: 0.015.toResponsive(context)),
                  )
                ],
              ));
  }

  Container topHeader(
      BuildContext context, RemoteOrderModel orderData, int btnIndex) {
    return Container(
      height: 0.07.h(context),
      width: 1.0.w(context),
      padding: EdgeInsets.all(0.015.toResponsive(context)),
      decoration: BoxDecoration(
          color: btnTapIndex == 0 ? secondaryColors : btnBghColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(11), topLeft: Radius.circular(11))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //left
        Row(
          children: [
            Text(
              "Table",
              style: TextStyle(
                  color: btnTapIndex == 0 ? primary : textColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 0.013.toResponsive(context)),
            ),
            SizedBox(
              width: 0.008.w(context),
            ),
            Text(orderData.tableName,
                style: TextStyle(
                    color: btnTapIndex == 0 ? primary : textColor,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 0.013.toResponsive(context))),
            SizedBox(
              width: 0.008.w(context),
            ),
            Image.asset("assets/images/vectro7.png"),
            SizedBox(
              width: 0.008.w(context),
            ),
            Text(
              "5Items",
              style: TextStyle(
                  color: btnTapIndex == 0 ? primary : textColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 0.012.toResponsive(context)),
            ),
          ],
        ),
        //Right

        Row(
          children: [
            Row(
              children: [
                Text(
                  "Order",
                  style: TextStyle(
                      color: btnTapIndex == 0 ? primary : textColor,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 0.013.toResponsive(context)),
                ),
                Text(
                  orderData.orderNo.toString(),
                  style: TextStyle(
                      color: btnTapIndex == 0 ? primary : textColor,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 0.013.toResponsive(context)),
                ),
              ],
            ),
            SizedBox(
              width: 0.008.w(context),
            ),
            Image.asset("assets/images/vectro7.png"),
            SizedBox(
              width: 0.008.w(context),
            ),
            Text(
              "1m ago",
              style: TextStyle(
                  color: btnTapIndex == 0 ? primary : textColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 0.013.toResponsive(context)),
            ),
          ],
        )
      ]),
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
          InkWell(
            onTap: () {
              setState(() {
                btnTapIndex = 0;
                log(btnTapIndex.toString());
              });
            },
            child: Text(
              "Order",
              style: TextStyle(
                  color: textColor,
                  fontFamily: "RobotoRegular",
                  fontWeight: FontWeight.w600,
                  fontSize: 0.017.toResponsive(context)),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                btnTapIndex = 1;
                log(btnTapIndex.toString());
              });
            },
            child: Container(
              height: 0.9.h(context),
              width: 0.13.w(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/orderhistory.png"))),
            ),
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
